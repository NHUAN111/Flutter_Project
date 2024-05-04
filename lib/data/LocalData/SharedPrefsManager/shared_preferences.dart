import 'dart:convert';
import 'package:project_specialized_1/data/LocalData/SharedPrefsManager/base_model.dart';
import 'package:project_specialized_1/model/coupon_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/user_model.dart';

class SharedPrefsManager {
  static late SharedPreferences _preferences;

  // Khởi tạo SharedPreferences
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Thiết lập dữ liệu user vào SharedPreferences
  static Future<void> setDataUser(String key, UserModel data) async {
    final String jsonData = json.encode(data.toJson());
    await _preferences.setString(key, jsonData);
  }

  // Lấy dữ liệu từ user SharedPreferences
  static UserModel? getData(String key) {
    final String? jsonData = _preferences.getString(key);
    if (jsonData != null) {
      try {
        final Map<String, dynamic> dataMap = json.decode(jsonData);
        return UserModel.fromJson(dataMap);
      } catch (e) {
        print('Error decoding data for key $key: $e');
        return null;
      }
    }
    return null;
  }

  // Thiết lập dữ liệu user vào SharedPreferences
  static Future<void> setDataCoupon(String key, CouponModel data) async {
    final String jsonData = json.encode(data.toJson());
    await _preferences.setString(key, jsonData);
  }

  // Lấy dữ liệu từ user SharedPreferences
  static CouponModel? getDataCoupon(String key) {
    final String? jsonData = _preferences.getString(key);
    if (jsonData != null) {
      try {
        final Map<String, dynamic> dataMap = json.decode(jsonData);
        return CouponModel.fromJson(dataMap);
      } catch (e) {
        print('Error decoding data for key $key: $e');
        return null;
      }
    }
    return null;
  }

  // Xóa dữ liệu từ SharedPreferences
  static Future<void> removeData(String key) async {
    await _preferences.remove(key);
  }
}
