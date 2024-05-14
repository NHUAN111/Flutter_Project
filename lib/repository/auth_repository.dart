import 'dart:convert';

import 'package:project_specialized_1/constant/constant.dart';
import 'package:project_specialized_1/data/network/BaseAPIServices.dart';
import 'package:project_specialized_1/data/network/NetWorkApiServices.dart';
import 'package:project_specialized_1/model/user_model.dart';
import 'package:project_specialized_1/res/app_url.dart';

import '../data/LocalData/SharedPrefsManager/shared_preferences.dart';

class Authrepository {
  BaseApiServices apiServices = NetWorkApiServices();

  Future<UserModel?> loginUser(String name, String password) async {
    try {
      var datas = {
        'customer_name': name,
        'customer_pass': password,
      };
      var response =
          await apiServices.getPostApiResponse(AppUrl.loginUrl, datas);

      Map<String, dynamic> data = json.decode(response.body);

      if (data['status_code'] == 200) {
        List<dynamic> userData = data['data'];
        UserModel user = UserModel.fromJson(userData[0]);

        // Khởi tạo SharedPreferences
        await SharedPrefsManager.init();
        await SharedPrefsManager.setDataUser(Constant.USER_PREFERENCES, user);
        print('Data saved login');
        return user;
      } else {
        throw Exception(data['message']);
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<UserModel?> registerUser(UserModel userModel) async {
    try {
      var datas = {
        'customer_name': userModel.customerName,
        'customer_email': userModel.customerEmail,
        'customer_pass': userModel.customerPass,
        'customer_phone': userModel.customerPhone,
      };

      var response =
          await apiServices.getPostApiResponse(AppUrl.registerUrl, datas);

      Map<String, dynamic> data = json.decode(response.body);
      if (data['status_code'] == 200) {
        List<dynamic> userData = data['data'];
        UserModel user = UserModel.fromJson(userData[0]);

        // Khởi tạo SharedPreferences
        await SharedPrefsManager.init();
        await SharedPrefsManager.setDataUser(Constant.USER_PREFERENCES, user);
        print('Data saved register');
      } else {
        throw Exception(data['message']);
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
    return null;
  }
}
