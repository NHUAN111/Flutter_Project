import 'package:project_specialized_1/model/orders_model.dart';

import 'shipping_model.dart';

class OrdersDetailModel {
  late String orderCode;
  late String foodName;
  late int foodPrice;
  late int foodSalesQuantity;
  late String foodImg;
  late int totalPrice;
  OrdersModel? order;
  ShippingModel? dataShipping;

  OrdersDetailModel({
    required this.orderCode,
    required this.foodName,
    required this.foodPrice,
    required this.foodSalesQuantity,
    required this.foodImg,
    required this.totalPrice,
    this.order,
    this.dataShipping,
  });
  factory OrdersDetailModel.fromJson(Map<String, dynamic> json) {
    return OrdersDetailModel(
      orderCode: json['order_code'],
      foodName: json['food_name'],
      foodPrice: json['food_price'],
      foodSalesQuantity: json['food_sales_quantity'],
      foodImg: json['food_img'],
      totalPrice: json['total_price'],
      order: json['order'] != null ? OrdersModel.fromJson(json['order']) : null,
      dataShipping: json['data_shipping'] != null
          ? ShippingModel.fromJson(json['data_shipping'])
          : null,
    );
  }
}
