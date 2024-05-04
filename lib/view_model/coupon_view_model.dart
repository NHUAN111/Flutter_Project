import 'package:flutter/material.dart';
import 'package:project_specialized_1/model/coupon_model.dart';
import 'package:project_specialized_1/repository/coupon_repository.dart';

class CouponViewModel with ChangeNotifier {
  final CouponRepository _couponRepository = CouponRepository();
  List<CouponModel> _couponList = [];
  List<CouponModel> get coupons => _couponList;

  Future<List<CouponModel>> fechCoupons() async {
    try {
      _couponList = await _couponRepository.fechCoupons();
      notifyListeners();
      return _couponList;
    } catch (e) {
      print('Error fetching coupons $e');
      rethrow;
    }
  }
}
