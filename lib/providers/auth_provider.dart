import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kurdbid/components/colors.dart';
import 'package:kurdbid/models/admin_model.dart';
import 'package:kurdbid/providers/upload_img.dart';
import 'package:kurdbid/shared_preferences/shared_pref_barrel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/snack_bar.dart';
import '../models/user_model.dart';

import '../shared_preferences/role.dart';
import '../shared_preferences/screens_state_manager.dart';
import '../user_screens/otp_verification_screen.dart';

class AuthProvider extends ChangeNotifier {
  //int _isSignedIn = 0;
  //int get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool? isApproved = false;
  String? _uid;
  String get uid => _uid!;
  // The model to get set in user data
  UserModel? _userModel;
  UserModel get userModel => _userModel!;
  // The model  to get set in doctors data
  AdminModel? _adminModel;
  AdminModel get adminModel => _adminModel!;
  Color errorBorder = backgroundGrey1;

  String _userID = '';
  String get userID => _userID;
  // bool _codeNotCorrect = false;
  // bool get codeNotCorrect => _codeNotCorrect;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseAuth get firebaseAuth => _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // AuthProvider() {
  //   checkSign();
  // }

  // void checkSign() async {
  //   final SharedPreferences s = await SharedPreferences.getInstance();
  //   _isSignedIn = s.getInt("is_signedin",) ?? 0;
  //   notifyListeners();
  // }

  Future setSignIn() async {
    // ScreenStateManager.setPageOrderID(1);
    notifyListeners();
  }

  // signin
  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    OTPVerification(verificationId: verificationId),
              ),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(
        bgColor: Colors.redAccent,
        content: e.message.toString(),
        context: context,
        textColor: Colors.white,
      );
    }
  }

  // verify otp
  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOtp,
      );

      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;

      if (user != null) {
        // carry our logic
        _uid = user.uid;
        errorBorder = primaryGreen;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorBorder = Colors.redAccent;
      //showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }

    // Future.delayed(Duration(seconds: 4)).then((value) {
    //  // _codeNotCorrect = false;
    //   notifyListeners();
    //   debugPrint('EXECUTED----------------');
    // });
  }

  // Future<bool> isDoctorApproved() async {
  //   DocumentSnapshot snapshot = await _firebaseFirestore
  //       .collection("doctors")
  //       .doc(AppointmentProvider.currentUser!.uid)
  //       .get();

  //   if (snapshot.get('isApproved')) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // DATABASE OPERTAIONS
  Future<bool> checkExistingPhone(String phoneNumber) async {
    bool isFound = false;

    QuerySnapshot querySnapshot = await _firebaseFirestore
        .collection(!Role.getRole() ? "users" : "admin")
        .get();

    for (var i in querySnapshot.docs) {
      if (phoneNumber == i.get('phoneNumber')) {
        //debugPrint(i.get('phoneNumber'));

        isFound = true;
      }
    }

    return isFound;
  }

  // DATABASE OPERTAIONS
  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot = await _firebaseFirestore
        .collection(Role.getRole() ? "users" : "admin")
        .doc(_uid)
        .get();

    _userID = snapshot.id;

    if (snapshot.exists) {
      //print("USER EXISTS");

      return true;
    } else {
      //print("NEW USER");
      return false;
    }
  }

  // Storing user data to firebase
  void saveUserDataToFirebase({
    required BuildContext context,
    required UserModel userModel,
    required File profilePic,
    required File frontSide,
    required File backSide,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      await storeFileToStorage("profilePic/$_uid", profilePic).then((value) {
        userModel.profilePic = value;
        userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
      }).then((value) async {
        await storeFileToStorage("frontIdCards/$_uid", frontSide).then((value) {
          userModel.frontIdCardUrl = value;
        });
      }).then((value) async {
        await storeFileToStorage("backIdCards/$_uid", backSide).then((value) {
          userModel.backIdCardUrl = value;
        });
      });

      _userModel = userModel;

      // uploading to database
      await _firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser!.uid)
          .set(userModel.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(
        bgColor: Colors.redAccent,
        content: e.message.toString(),
        context: context,
        textColor: Colors.white,
      );
      _isLoading = false;
      notifyListeners();
    }
  }

  // Storing Doctors data to firebase
  void saveAdminDataToFirebase({
    required BuildContext context,
    required AdminModel adminModel,
    required File profilePic,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      await storeFileToStorage("profilePic/$_uid", profilePic).then((value) {
        adminModel.profileImgUrl = value;
        adminModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
      });

      _adminModel = adminModel;

      // uploading to database
      await _firebaseFirestore
          .collection("admin")
          .doc(_uid)
          .set(adminModel.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(
        bgColor: Colors.redAccent,
        content: e.message.toString(),
        context: context,
        textColor: Colors.white,
      );
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get Doctor info from firebase
  Future getAdminDataFromFirestore() async {
    await _firebaseFirestore
        .collection("admin")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _adminModel = AdminModel(
        firstName: snapshot['firstName'] ?? '',
        lastName: snapshot['lastName'] ?? '',
        phoneNumber: snapshot['phoneNumber'] ?? '',
        profileImgUrl: snapshot['profileImgUrl'] ?? '',
        uid: snapshot['uid'],
      );
      _uid = adminModel.uid;
    });
  }

// Get user info from firebase
  Future getUserDataFromFirestore() async {
    await _firebaseFirestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _userModel = UserModel(
        firstName: snapshot['firstName'] ?? '',
        lastName: snapshot['lastName'] ?? '',
        gender: snapshot['gender'] ?? '',
        profilePic: snapshot['profilePic'] ?? '',
        province: snapshot['province'] ?? '',
        city: snapshot['city'] ?? '',
        frontIdCardUrl: snapshot['frontIdCardUrl'] ?? '',
        backIdCardUrl: snapshot['backIdCardUrl'] ?? '',
        idNumber: snapshot['idNumber'] ?? '',
        phoneNumber: snapshot['phoneNumber'] ?? '',
        isApproved: snapshot['isApproved'],
        deviceToken: snapshot['deviceToken'],
      );
    });
  }

  // STORING DATA LOCALLY
  Future saveUserDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user_model", jsonEncode(userModel.toMap()));
  }

  Future getDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? '';
    _userModel = UserModel.fromMap(jsonDecode(data));
    //_uid = _userModel!.uid;
    notifyListeners();
  }

  // STORING DOCTOR DATA LOCALLY
  Future saveAdminDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("doc_model", jsonEncode(adminModel.toMap()));
  }

  Future getDoctorDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("doc_model") ?? '';
    _adminModel = AdminModel.fromMap(jsonDecode(data));
    _uid = _adminModel!.uid;
    notifyListeners();
  }

  Future userSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();

    await _firebaseAuth.signOut();
    ScreenStateManager.setPageOrderID(0);
    // BottomNavBar().index = 0;
    notifyListeners();
    s.clear();
  }
}


























































// import 'package:kurdbid/providers/verifyOTP.dart';

// import '../components/components_barrel.dart';
// import '../public_packages.dart';
// import '../shared_preferences/role.dart';
// import '../user_screens/otp_verification_screen.dart';


// class AuthProvider extends ChangeNotifier {

  
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   FirebaseAuth get firebaseAuth => _firebaseAuth;
//   final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//   String _userID = '';
//   String get userID => _userID;

//   Future setSignIn() async {
//     // ScreenStateManager.setPageOrderID(1);
//     notifyListeners();
//   }

//   // signin
//   void signInWithPhone(BuildContext context, String phoneNumber) async {
//     try {
//       await _firebaseAuth.verifyPhoneNumber(
//           phoneNumber: phoneNumber,
//           verificationCompleted:
//               (PhoneAuthCredential phoneAuthCredential) async {
//             await _firebaseAuth.signInWithCredential(phoneAuthCredential);
//           },
//           verificationFailed: (error) {
//             throw Exception(error.message);
//           },
//           codeSent: (verificationId, forceResendingToken) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) =>
//                     OTPVerification(verificationId: verificationId),
//               ),
//             );
//           },
//           codeAutoRetrievalTimeout: (verificationId) {});
//     } on FirebaseAuthException catch (e) {
//       showSnackBar(
//         bgColor: Colors.redAccent,
//         content: e.message.toString(),
//         context: context,
//         textColor: Colors.white,
//       );
//     }
//   }

//   // DATABASE OPERTAIONS
//   Future<bool> checkExistingPhone(String phoneNumber) async {
//     bool isFound = false;

//     QuerySnapshot querySnapshot = await _firebaseFirestore
//         .collection(!Role.getRole() ? "users" : "doctors")
//         .get();

//     for (var i in querySnapshot.docs) {
//       if (phoneNumber == i.get('phoneNumber')) {
//         debugPrint(i.get('phoneNumber'));

//         isFound = true;
//       }
//     }

//     return isFound;
//   }

//   // DATABASE OPERTAIONS
//   Future<bool> checkExistingUser() async {
//     DocumentSnapshot snapshot = await _firebaseFirestore
//         .collection(Role.getRole() ? "users" : "doctors")
//         .doc(VerifyOTP().uid)
//         .get();
//     _userID = snapshot.id;

//     if (snapshot.exists) {
//       //print("USER EXISTS");

//       return true;
//     } else {
//       //print("NEW USER");
//       return false;
//     }
//   }
// }
