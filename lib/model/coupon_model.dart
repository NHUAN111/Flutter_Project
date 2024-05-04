import 'package:project_specialized_1/data/LocalData/SharedPrefsManager/base_model.dart';

class CouponModel extends BaseModel {
  late String couponName;
  late String couponCode;
  late int couponNumber;
  late int couponCondition;
  late String couponStart;
  late String couponEnd;

  CouponModel({
    required this.couponName,
    required this.couponCode,
    required this.couponNumber,
    required this.couponCondition,
    required this.couponStart,
    required this.couponEnd,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
        couponName: json['coupon_name'].toString(),
        couponCode: json['coupon_code'].toString(),
        couponNumber: json['coupon_number'],
        couponCondition: json['coupon_condition'],
        couponStart: json['coupon_start'].toString(),
        couponEnd: json['coupon_end'].toString());
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'coupon_code': couponCode,
      'coupon_number': couponNumber,
      'coupon_condition': couponCondition,
    };
  }
}
