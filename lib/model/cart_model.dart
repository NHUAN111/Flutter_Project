import 'dart:convert';

import 'package:project_specialized_1/data/LocalData/SharedPrefsManager/base_model.dart';

class CartModel extends BaseModel {
  final int idFood;
  final int customerId;
  final String name;
  String price;
  final String imageUrl;
  int quantity;

  CartModel({
    required this.idFood,
    required this.customerId,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': idFood,
      'customer_id': customerId,
      'name': name,
      'price': price.toString(),
      'img_url': imageUrl,
      'quantity': quantity,
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      idFood: json['id'] as int,
      customerId: json['customer_id'] as int,
      name: json['name'] as String,
      price: json['price'].toString(), // Chuyển đổi sang kiểu String
      imageUrl: json['img_url'] as String,
      quantity: json['quantity'] as int,
    );
  }

  void updateQuantity(int newQuantity) {
    quantity = newQuantity;
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
