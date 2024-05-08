import 'dart:convert';
import 'package:project_specialized_1/constant/constant.dart';
import 'package:project_specialized_1/data/LocalData/SharedPrefsManager/shared_preferences.dart';
import 'package:project_specialized_1/data/LocalData/SqfLite/FeeshipLocalData.dart';
import 'package:project_specialized_1/data/network/BaseAPIServices.dart';
import 'package:project_specialized_1/data/network/NetWorkApiServices.dart';
import 'package:project_specialized_1/model/city_model.dart';
import 'package:project_specialized_1/model/feeship_model.dart';
import 'package:project_specialized_1/model/pronvice_model.dart';
import 'package:project_specialized_1/model/ward_mode.dart';
import 'package:project_specialized_1/res/app_url.dart';

class FeeshipRepository {
  final DatabaseHelperFeeship _databaseHelperFeeship = DatabaseHelperFeeship();
  BaseApiServices apiServices = NetWorkApiServices();
  Future<List<CityModel>> fechCitys() async {
    final response = await apiServices.getGetApiResponse(AppUrl.cityAddress);

    Map<String, dynamic> data = json.decode(response.body);
    if (data['status_code'] == 200) {
      List<dynamic> jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((city) => CityModel.fromJson(city)).toList();
    } else {
      throw Exception('Failed to load city');
    }
  }

  Future<List<PronviceModel>> fechPronvice(String nameCity) async {
    var requestData = {
      'name_city': nameCity,
    };
    final response = await apiServices.getPostApiResponse(
        AppUrl.pronviceAddress, requestData);

    Map<String, dynamic> data = json.decode(response.body);
    if (data['status_code'] == 200) {
      List<dynamic> jsonResponse = json.decode(response.body)['data'];
      return jsonResponse
          .map((pronvice) => PronviceModel.fromJson(pronvice))
          .toList();
    } else {
      throw Exception('Failed to load food pronvice');
    }
  }

  Future<List<WardModel>> fechWard(String nameQuanHuyen) async {
    var requestData = {
      'name_province': nameQuanHuyen,
    };
    final response =
        await apiServices.getPostApiResponse(AppUrl.wardAddress, requestData);

    Map<String, dynamic> data = json.decode(response.body);
    if (data['status_code'] == 200) {
      List<dynamic> jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((ward) => WardModel.fromJson(ward)).toList();
    } else {
      throw Exception('Failed to load food ward');
    }
  }

  Future<void> getFeeship(String address) async {
    var requestData = {
      'shipping_address': address,
    };
    var response =
        await apiServices.getPostApiResponse(AppUrl.shippingFee, requestData);

    Map<String, dynamic> data = json.decode(response.body);
    if (data['status_code'] == 200) {
      // Access the 'data' field directly to get the fee value
      dynamic feeData = data['data'];
      int feeValue = feeData['fee_feeship'];

      final user = SharedPrefsManager.getData(Constant.USER_PREFERENCES);
      int? customerid = user!.customerId;
      FeeshipModel feeshipModel = FeeshipModel(
          customerId: customerid,
          feeship: feeValue,
          address: address,
          statusFee: 0);
      await _databaseHelperFeeship.insertFeeShip(feeshipModel);
    } else {
      throw Exception('Failed feeship');
    }
  }
}
