class Item {
  String userName;
  String userID;
  String userPhone;
  //String imgUrl;
  String productName;
  String imgUrl;
  String companyName;
  String startPrice;
  String category;
  String address;
  String duration;
  String description;
  String buyerPrice;
  String buyerName;
  String buyerId;
  String buyerPhone;
  String deviceToken;
  bool isApproved = false;

  Item({
    required this.userName,
    required this.userID,
    required this.userPhone,
    required this.productName,
    required this.companyName,
    required this.imgUrl,
    required this.startPrice,
    required this.category,
    required this.address,
    required this.duration,
    required this.description,
    required this.buyerPrice,
    required this.buyerName,
    required this.buyerId,
    required this.buyerPhone,
    required this.deviceToken,
    required this.isApproved,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      productName: map['productName'],
      imgUrl: map['imgUrl'],
      companyName: map['companyName'],
      startPrice: map['startPrice'],
      category: map['category'],
      address: map['address'],
      duration: map['duration'],
      description: map['description'],
      isApproved: map['isApproved'],
      userID: map['userID'],
      userName: map['userName'],
      userPhone: map['userPhone'],
      buyerId: map['buyerId'],
      buyerName: map['buyerName'],
      buyerPhone: map['buyerPhone'],
      buyerPrice: map['buyerPrice'],
      deviceToken: map["deviceToken"]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'companyName': companyName,
      'imgUrl': imgUrl,
      'startPrice': startPrice,
      'category': category,
      'address': address,
      'duration': duration,
      'description': description,
      'isApproved': isApproved,
      'userID': userID,
      'userName': userName,
      'userPhone': userPhone,
      'buyerId': buyerId,
      'buyerName': buyerName,
      'buyerPhone': buyerPhone,
      'buyerPrice': buyerPrice,
      "deviceToken":deviceToken
    };
  }
}
