import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_specialized_1/data/network/BaseAPIServices.dart';
import 'package:project_specialized_1/data/network/NetWorkApiServices.dart';
import 'package:project_specialized_1/model/category_mode.dart';
import 'package:project_specialized_1/res/app_url.dart';

class CategoryRepository {
  BaseApiServices apiServices = NetWorkApiServices();
  Future<List<CategoryModel>> fetchCategories() async {
    final response = await apiServices.getGetApiResponse(AppUrl.categoriesUrl);

    Map<String, dynamic> data = json.decode(response.body);
    if (data['status_code'] == 200) {
      List<dynamic> jsonResponse = json.decode(response.body)['data'];
      return jsonResponse
          .map((category) => CategoryModel.fromJson(category))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
