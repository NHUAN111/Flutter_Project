import 'package:flutter/material.dart';
import 'package:project_specialized_1/model/slider_model.dart';
import 'package:project_specialized_1/repository/slider_repository.dart';

class SliderViewModel with ChangeNotifier {
  final SliderRepository _repository = SliderRepository();
  List<SliderModel> _slider = [];
  List<SliderModel> get sliders => _slider;

  Future<List<SliderModel>> fetchSliders() async {
    try {
      _slider = await _repository.fetchSliders();
      notifyListeners();
      return _slider;
    } catch (e) {
      print('Error fetching sliders: $e');
      rethrow; // Throw the error further up the call stack
    }
  }
}
