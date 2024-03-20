import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:project_specialized_1/data/app_excaption.dart';
import 'package:project_specialized_1/data/network/BaseAPIServices.dart';
import 'package:http/http.dart' as http;

class NetWorkApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        return response;
      } else {
        // Nếu không thành công, ném ra một ngoại lệ và xử lý ngoại lệ này ở nơi gọi hàm
        throw FechDataExcaption(
            'Failed to fetch data. Status code: ${response.statusCode}');
      }
    } on SocketException {
      throw FechDataExcaption("No internet connection");
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    try {
      Response response = await post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        return response;
      } else {
        // Nếu không thành công, ném ra một ngoại lệ và xử lý ngoại lệ này ở nơi gọi hàm
        throw FechDataExcaption(
            'Failed to fetch data. Status code: ${response.statusCode}');
      }
    } on SocketException {
      throw FechDataExcaption("No internet connection");
    } catch (e) {
      // Bắt và xử lý các ngoại lệ khác nếu có
      throw FechDataExcaption("Error: $e");
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 400:
        throw BadRequestExcaption(response.body.toString());

      case 404:
        throw UnauthorisedExcaption(response.body.toString());

      case 500:
      default:
        throw FechDataExcaption(
            'Error accourded while communicating with server  with status code ${response.statusCode}');
    }
  }
}
