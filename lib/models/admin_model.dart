class AdminModel {
  String firstName;
  String lastName;
  String phoneNumber;
  String profileImgUrl;
  String uid;

  AdminModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.profileImgUrl,
    required this.uid,
  });

  // from map
  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      profileImgUrl: map['profileImgUrl'] ?? '',
      uid: map['uid'],
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "profileImgUrl": profileImgUrl,
      "uid": uid,
    };
  }
}
