class FavouriteModel {
  int? customerId;
  int? foodId;
  String? foodName;
  String? foodPrice;
  String? foodDesc;
  String? foodImg;
  int? totalOrders;

  FavouriteModel({
    this.customerId,
    this.foodId,
    this.foodName,
    this.foodPrice,
    this.foodDesc,
    this.foodImg,
    this.totalOrders,
  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(
      customerId: json['customerId'],
      foodId: json['foodId'],
      foodName: json['foodName'],
      foodPrice: json['foodPrice'],
      foodDesc: json['foodDesc'],
      foodImg: json['foodImg'],
      totalOrders: json['totalOrders'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'foodId': foodId,
      'foodName': foodName,
      'foodPrice': foodPrice,
      'foodDesc': foodDesc,
      'foodImg': foodImg,
      'totalOrders': totalOrders,
    };
  }
}
