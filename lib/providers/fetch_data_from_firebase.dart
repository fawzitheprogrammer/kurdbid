// import 'package:kurdbid/models/admin_model.dart';
// import 'package:kurdbid/providers/verifyOTP.dart';
// import 'package:kurdbid/public_packages.dart';

// import '../models/user_model.dart';

// class FetchData extends ChangeNotifier {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   FirebaseAuth get firebaseAuth => _firebaseAuth;
//   final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//   UserModel? _userModel;
//   UserModel get userModel => _userModel!;
//   AdminModel? _adminModel;
//   AdminModel get adminModel => _adminModel!;

//   // Get user info from firebase
//   Future getUserDataFromFirestore() async {
//     await _firebaseFirestore
//         .collection("users")
//         .doc(_firebaseAuth.currentUser!.uid)
//         .get()
//         .then((DocumentSnapshot snapshot) {
//       _userModel = UserModel(
//         firstName: snapshot['firstName'] ?? '',
//         lastName: snapshot['lastName'] ?? '',
//         gender: snapshot['gender'] ?? '',
//         profilePic: snapshot['profilePic'] ?? '',
//         province: snapshot['province'] ?? '',
//         city: snapshot['city'] ?? '',
//         idCardUrl: snapshot['idCardUrl'] ?? '',
//         idNumber: snapshot['idNumber'] ?? '',
//         phoneNumber: snapshot['phoneNumber'] ?? '',
//       );
//       //VerifyOTP().uid = userModel.uid;
//     });
//     notifyListeners();
//   }

//   // Get Doctor info from firebase
//   Future getDoctorDataFromFirestore() async {
//     await _firebaseFirestore
//         .collection("doctors")
//         .doc(_firebaseAuth.currentUser!.uid)
//         .get()
//         .then((DocumentSnapshot snapshot) {
//       _adminModel = AdminModel(
//         firstName: snapshot['firstName'] ?? '',
//         lastName: snapshot['lastName'] ?? '',
//         phoneNumber: snapshot['phoneNumber'] ?? '',
//         profileImgUrl: snapshot['profileImgUrl'] ?? '',
//       );
//       //_uid = doctorModel.uid;
//     });
//     notifyListeners();
//   }
// }
