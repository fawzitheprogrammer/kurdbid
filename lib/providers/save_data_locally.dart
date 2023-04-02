import 'dart:convert';

import 'package:kurdbid/models/user_model.dart';
import 'package:kurdbid/public_packages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveDataLocally extends ChangeNotifier {
  // The model to get set in user data
  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  // STORING DATA LOCALLY
  Future saveUserDataToSP(UserModel userModel) async {
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
}
