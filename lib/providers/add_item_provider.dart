import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kurdbid/models/admin_model.dart';
import 'package:kurdbid/models/item_mode.dart';
import 'package:kurdbid/providers/upload_img.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/snack_bar.dart';
import 'package:http/http.dart' as http;

class ItemAndPostProvider extends ChangeNotifier {
  AdminModel? _adminModel;
  AdminModel get doctorModel => _adminModel!;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  static bool isSave = true;

  String _deviceToken = '';
  String get deviceToken => _deviceToken;

  static String postDocID = '';
  // String get appointmentDocument => _appointmentDocumentID;
  //bool get isSave => _isLoading;

  static User? currentUser = FirebaseAuth.instance.currentUser;
  Item? _item;
  Item get item => _item!;

  //final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  //final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // String serverKey =
//;

  static void sendPushMessage(String body, String title, String token) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAHWN3jb4:APA91bGpmvmNtPPPgrZjnFTF7vkDgLYVSTBNM_I5yldoGpmzmW7VVzNhQhoIhcBKCzxxgJkAKfX_dMlfiKw54P_0u3T2uQznMs9oGSo7HT_U7TyBUjB2Y_riuGAzsRd1RkE7jRA5Zcsm',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
      //print('done');
    } catch (e) {
      print("error push notification");
    }
  }

  // DATABASE OPERTAIONS
  Future<bool> checkAppointmentExisting(String doctorID, String userID) async {
    bool isFound = false;

    QuerySnapshot querySnapshot = await _firebaseFirestore
        .collection("users")
        .doc(userID)
        .collection('posts')
        .get();

    for (var i in querySnapshot.docs) {
      if (doctorID == i.get('doctorID')) {
        //debugPrint(i.get('doctorID'));

        isFound = true;
      }
    }

    return isFound;
  }

  Future<String> getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      _deviceToken = token!;
      notifyListeners();
    });

    return deviceToken;
  }

  String generateRandomString() {
    var random = Random();
    var letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    var numbers = '0123456789';
    var result = '';
    for (var i = 0; i < 20; i++) {
      var charSet = (i % 2 == 0) ? letters : numbers;
      var randomChar = charSet[random.nextInt(charSet.length)];
      result += randomChar;
    }
    return result;
  }

  // Storing user data to firebase
  void saveFavDoctor({
    required BuildContext context,
    required AdminModel adminModel,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      // await storeFileToStorage("profilePic/$_uid", profilePic).then((value) {
      //   userModel.profilePic = value;
      //   userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
      //   userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
      //   userModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      // });

      _adminModel = adminModel;

      // uploading to database
      await _firebaseFirestore
          .collection("users")
          .doc(currentUser!.uid)
          .collection('fav')
          .doc()
          .set(doctorModel.toMap())
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

  // Storing user data to firebase
  void saveItemDataToFirebase({
    required BuildContext context,
    required Item item,
    required File img,
    //required doctorID,
    //required userID,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      //uploading image to firebase storage.
      await storeFileToStorage("posts/${item.productName}", img).then((value) {
        item.imgUrl = value;
      });

      _item = item;

      //_appointmentDocumentID = ran;
      //

      postDocID = generateRandomString();

      await _firebaseFirestore
          .collection("posts")
          .doc(postDocID)
          .set(item.toMap());
      onSuccess();
      notifyListeners();
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

  // STORING DATA LOCALLY
  Future saveItemDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("appointment", jsonEncode(item.toMap()));
  }

  Future getDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("appointment") ?? '';
    _item = Item.fromMap(jsonDecode(data));
    notifyListeners();
  }

  // Get Doctor info from firebase
  Future getppointmentDataToFirebase() async {
    await _firebaseFirestore
        .collection("admin")
        .doc(currentUser!.uid)
        .collection('posts')
        .doc()
        .get()
        .then((DocumentSnapshot snapshot) {
      _item = Item(
        productName: snapshot['productName'],
        companyName: snapshot['companyName'],
        startPrice: snapshot['startPrice'],
        category: snapshot['category'],
        address: snapshot['address'],
        duration: snapshot['duration'],
        description: snapshot['description'],
        isApproved: snapshot['isApproved'],
        imgUrl: snapshot['imgUrl'],
        userID: snapshot['userID'],
        userName: snapshot['userName'],
        userPhone: snapshot['userPhone'],
        buyerId: '',
        buyerName: '',
        buyerPhone: '',
        buyerPrice: snapshot['startPrice'],
        deviceToken: snapshot['deviceToken'],
      );
    });
  }

  Future deleteAppointment(
      String documentID, String doctorId, String userID) async {
    await _firebaseFirestore
        .collection('users')
        .doc(userID)
        .collection('posts')
        .doc(documentID)
        .delete()
        .then((_) async {
      await _firebaseFirestore
          .collection('admin')
          .doc(doctorId)
          .collection('posts')
          .doc(documentID)
          .delete();
    });
  }

// // Get user info from firebase
//   Future getUserDataFromFirestore() async {
//     await _firebaseFirestore
//         .collection("users")
//         .doc(_firebaseAuth.currentUser!.uid)
//         .get()
//         .then((DocumentSnapshot snapshot) {
//       _uid = snapshot.id;
//     });
//   }
}
