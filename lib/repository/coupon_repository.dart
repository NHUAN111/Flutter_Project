import 'dart:convert';
import 'package:project_specialized_1/data/network/BaseAPIServices.dart';
import 'package:project_specialized_1/data/network/NetWorkApiServices.dart';
import 'package:project_specialized_1/res/app_url.dart';
import '../model/coupon_model.dart';

class CouponRepository {
  BaseApiServices apiServices = NetWorkApiServices();
  Future<List<CouponModel>> fechCoupons() async {
    final response = await apiServices.getGetApiResponse(AppUrl.coupons);

    Map<String, dynamic> data = json.decode(response.body);
    if (data['status_code'] == 200) {
      List<dynamic> jsonResponse = json.decode(response.body)['data'];
      return jsonResponse
          .map((coupon) => CouponModel.fromJson(coupon))
          .toList();
    } else {
      throw Exception('Failed to load coupon');
    }
  }
}
