import 'dart:convert';

import 'package:project_specialized_1/data/network/BaseAPIServices.dart';
import 'package:project_specialized_1/data/network/NetWorkApiServices.dart';
import 'package:project_specialized_1/model/slider_model.dart';
import 'package:project_specialized_1/res/app_url.dart';

class SliderRepository {
  BaseApiServices apiServices = NetWorkApiServices();
  Future<List<SliderModel>> fetchSliders() async {
    final response = await apiServices.getGetApiResponse(AppUrl.slidersUrl);

    Map<String, dynamic> data = json.decode(response.body);
    if (data['status_code'] == 200) {
      List<dynamic> jsonResponse = json.decode(response.body)['data'];
      return jsonResponse
          .map((slider) => SliderModel.fromJson(slider))
          .toList();
    } else {
      throw Exception('Failed to load sliders');
    }
  }
}
