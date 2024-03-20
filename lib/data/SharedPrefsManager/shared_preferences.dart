import 'dart:convert';
import 'package:project_specialized_1/data/SharedPrefsManager/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsManager {
  static late SharedPreferences _preferences;

  // Khởi tạo SharedPreferences
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Lưu dữ liệu vào SharedPreferences
  static Future<void> setData(String key, BaseModel data) async {
    final String jsonData = json.encode(data.toJson());
    await _preferences.setString(key, jsonData);
  }

  // Lấy dữ liệu từ SharedPreferences
  static T? getData<T extends BaseModel>(
      String key, T Function(Map<String, dynamic>) fromJson) {
    final String? jsonData = _preferences.getString(key);
    if (jsonData != null) {
      try {
        final Map<String, dynamic> dataMap = json.decode(jsonData);
        return fromJson(dataMap);
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
