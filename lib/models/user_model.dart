class UserModel {
  String firstName;
  String lastName;
  String gender;
  String profilePic;
  String province;
  String city;
  String frontIdCardUrl;
  String backIdCardUrl;
  String idNumber;
  String phoneNumber;
  String deviceToken;
  bool isApproved;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.profilePic,
    required this.province,
    required this.city,
    required this.frontIdCardUrl,
    required this.backIdCardUrl,
    required this.idNumber,
    required this.phoneNumber,
    required this.deviceToken,
    required this.isApproved,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      gender: map['gender'] ?? '',
      profilePic: map['profilePic'] ?? '',
      province: map['province'] ?? '',
      city: map['city'] ?? '',
      frontIdCardUrl: map['frontIdCardUrl'] ?? '',
      backIdCardUrl: map['backIdCardUrl'] ?? '',
      idNumber: map['idNumber'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      deviceToken: map['deviceToken'],
      isApproved: map['isApproved'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender,
      "profilePic": profilePic,
      "province": province,
      "city": city,
      "frontIdCardUrl": frontIdCardUrl,
      "backIdCardUrl": backIdCardUrl,
      "idNumber": idNumber,
      "phoneNumber": phoneNumber,
      "isApproved": isApproved,
      "deviceToken":deviceToken
    };
  }
}
