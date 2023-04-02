class UserModel {
  String firstName;
  String lastName;
  String gender;
  String profilePic;
  String province;
  String city;
  String idCardUrl;
  String idNumber;
  String phoneNumber;
  String uid;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.profilePic,
    required this.province,
    required this.city,
    required this.idCardUrl,
    required this.idNumber,
    required this.phoneNumber,
    required String this.uid,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        firstName: map['firstName'] ?? '',
        lastName: map['lastName'] ?? '',
        gender: map['gender'] ?? '',
        profilePic: map['profilePic'] ?? '',
        province: map['province'] ?? '',
        city: map['city'] ?? '',
        idCardUrl: map['idCardUrl'] ?? '',
        idNumber: map['idNumber'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        uid: map['uid'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender,
      "profilePic": profilePic,
      "province": province,
      "city": city,
      "idCardUrl": idCardUrl,
      "idNumber": idNumber,
      "phoneNumber": phoneNumber,
      "uid": uid
    };
  }
}
