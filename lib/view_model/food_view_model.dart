import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_specialized_1/model/food_mode.dart';
import 'package:project_specialized_1/repository/food_repository.dart';
import 'package:project_specialized_1/utils/routes/routes_name.dart';

class FoodViewModel with ChangeNotifier {
  final FoodRepository _repository = FoodRepository();
  List<FoodModel> _food = [];
  List<FoodModel> get foods => _food;

  late FoodModel _foodModel;
  FoodModel get foodDeatils => _foodModel;

  Future<List<FoodModel>> foodBestSeller() async {
    try {
      _food = await _repository.fechFoodBestSeller();
      notifyListeners();
      return _food;
    } catch (e) {
      print('Error fetching food best seller: $e');
      rethrow; // Throw the error further up the call stack
    }
  }

  Future<List<FoodModel>> foodNew() async {
    try {
      _food = await _repository.fechFoodNew();
      notifyListeners();
      return _food;
    } catch (e) {
      print('Error fetching food new: $e');
      rethrow; // Throw the error further up the call stack
    }
  }

  Future<List<FoodModel>> foodDiscount() async {
    try {
      _food = await _repository.fechFoodDiscount();
      notifyListeners();
      return _food;
    } catch (e) {
      print('Error fetching food discount: $e');
      rethrow; // Throw the error further up the call stack
    }
  }

  Future<List<FoodModel>> foodAll() async {
    try {
      _food = await _repository.fechFoodAll();
      notifyListeners();
      return _food;
    } catch (e) {
      print('Error fetching food all: $e');
      rethrow; // Throw the error further up the call stack
    }
  }

  Future<FoodModel?> foodDetail(int foodId) async {
    try {
      _foodModel = await _repository.fechFoodDetail(foodId);
      notifyListeners();
      return _foodModel;
    } catch (error) {
      // print('Lỗi khi load dữ liệu chi tiết food: $error');
      if (kDebugMode) {
        print('Food detail $error');
      }
    }
    return null;
  }
}
