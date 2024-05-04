import 'package:flutter/material.dart';

import '../data/LocalData/SqfLite/CartLocalData.dart';
import '../model/cart_model.dart';

class CartViewModel with ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> addToCart(CartModel cartModel) async {
    try {
      await _databaseHelper.insertCart(cartModel);
      // return cartModel;
    } catch (e) {
      throw Exception('Failed to add product to cart: $e');
    }
  }

  Future<List<CartModel>> listAllCart(int customerId) async {
    try {
      return await _databaseHelper.getAllFoods(customerId);
    } catch (e) {
      print('{$e}');
      throw Exception('Failed to list alls food to cart: $e');
    }
  }

  Future<int> deleteCart(int id, int customerId) async {
    try {
      final result = await _databaseHelper.deleteCart(id, customerId);
      notifyListeners();
      return result;
    } catch (e) {
      throw Exception('Failed to delete cart: $e');
    }
  }

  Future<void> updateCart(int foodId, int customerId, int quantity) async {
    try {
      final result = _databaseHelper.updateQty(foodId, customerId, quantity);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to update cart: $e');
    }
  }
}
