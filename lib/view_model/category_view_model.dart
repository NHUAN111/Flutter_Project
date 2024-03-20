import 'package:flutter/material.dart';
import 'package:project_specialized_1/model/category_mode.dart';
import 'package:project_specialized_1/repository/category_repository.dart';

class CategoryViewModel with ChangeNotifier {
  final CategoryRepository _repository = CategoryRepository();
  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      _categories = await _repository.fetchCategories();
      notifyListeners();
      return _categories;
    } catch (e) {
      print('Error fetching categories: $e');
      rethrow; // Throw the error further up the call stack
    }
  }
}
