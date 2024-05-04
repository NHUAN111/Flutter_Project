import 'package:project_specialized_1/data/LocalData/SharedPrefsManager/base_model.dart';

class FoodModel extends BaseModel {
  final int foodId;
  final int categoryId;
  final String foodName;
  final String foodPrice;
  final String foodDesc;
  final String foodContent;
  final int foodCondition;
  final int foodNumber;
  final String foodImg;
  final int foodStatus;
  final int totalOrders;
  String? foodPriceDiscount;

  FoodModel(
      {required this.foodId,
      required this.categoryId,
      required this.foodName,
      required this.foodPrice,
      this.foodPriceDiscount,
      required this.foodDesc,
      required this.foodContent,
      required this.foodCondition,
      required this.foodNumber,
      required this.foodImg,
      required this.foodStatus,
      required this.totalOrders});

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      foodId: json['food_id'],
      categoryId: json['category_id'],
      foodName: json['food_name'],
      foodPrice: json['food_price'].toString(),
      foodPriceDiscount: json['food_price_discount'].toString(),
      foodDesc: json['food_desc'],
      foodContent: json['food_content'],
      foodCondition: json['food_condition'],
      foodNumber: json['food_number'],
      foodImg: json['food_img'],
      foodStatus: json['food_status'],
      totalOrders: json['total_orders'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'food_id': foodId,
    };
  }
}
