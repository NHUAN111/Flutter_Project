import 'dart:convert';

import 'package:project_specialized_1/data/network/BaseAPIServices.dart';
import 'package:project_specialized_1/data/network/NetWorkApiServices.dart';
import 'package:project_specialized_1/model/food_model.dart';
import 'package:project_specialized_1/res/app_url.dart';

class FoodRepository {
  BaseApiServices apiServices = NetWorkApiServices();
  Future<List<FoodModel>> fechFoodBestSeller() async {
    final response =
        await apiServices.getGetApiResponse(AppUrl.foodBestSellerUrl);

    Map<String, dynamic> data = json.decode(response.body);
    if (data['status_code'] == 200) {
      List<dynamic> jsonResponse = json.decode(response.body)['data'];
      return jsonResponse
          .map((foodBestSeller) => FoodModel.fromJson(foodBestSeller))
          .toList();
    } else {
      throw Exception('Failed to load foodBestSeller');
    }
  }

  Future<List<FoodModel>> fechFoodNew() async {
    final response = await apiServices.getGetApiResponse(AppUrl.foodNewUrl);

    Map<String, dynamic> data = json.decode(response.body);
    if (data['status_code'] == 200) {
      List<dynamic> jsonResponse = json.decode(response.body)['data'];
      return jsonResponse
          .map((foodNew) => FoodModel.fromJson(foodNew))
          .toList();
    } else {
      throw Exception('Failed to load foodNew');
    }
  }

  Future<List<FoodModel>> fechFoodDiscount() async {
    final response =
        await apiServices.getGetApiResponse(AppUrl.foodDiscountUrl);

    Map<String, dynamic> data = json.decode(response.body);
    if (data['status_code'] == 200) {
      List<dynamic> jsonResponse = json.decode(response.body)['data'];
      return jsonResponse
          .map((foodDiscount) => FoodModel.fromJson(foodDiscount))
          .toList();
    } else {
      throw Exception('Failed to load foodNew');
    }
  }

  Future<List<FoodModel>> fechFoodAll() async {
    final response = await apiServices.getGetApiResponse(AppUrl.foodAllUrl);

    Map<String, dynamic> data = json.decode(response.body);
    if (data['status_code'] == 200) {
      List<dynamic> jsonResponse = json.decode(response.body)['data'];
      return jsonResponse
          .map((foodAll) => FoodModel.fromJson(foodAll))
          .toList();
    } else {
      throw Exception('Failed to load foodAll');
    }
  }

  Future<FoodModel> fechFoodDetail(int foodId) async {
    var requestData = {
      'food_id': foodId.toString(),
    };
    final response =
        await apiServices.getPostApiResponse(AppUrl.foodDetailUrl, requestData);

    Map<String, dynamic> data = json.decode(response.body);
    if (data['status_code'] == 200) {
      FoodModel foodDetailData = FoodModel.fromJson(data['data']);
      return foodDetailData;
    } else {
      throw Exception('Failed to load food detail');
    }
  }

  Future<List<FoodModel>> fechFoodSameCategory(int foodId) async {
    var requestData = {
      'food_id': foodId.toString(),
    };
    final response = await apiServices.getPostApiResponse(
        AppUrl.foodSameCategoryUrl, requestData);

    Map<String, dynamic> data = json.decode(response.body);
    if (data['status_code'] == 200) {
      List<dynamic> jsonResponse = json.decode(response.body)['data'];
      return jsonResponse
          .map((foodSameCategory) => FoodModel.fromJson(foodSameCategory))
          .toList();
    } else {
      throw Exception('Failed to load food same category');
    }
  }
}
