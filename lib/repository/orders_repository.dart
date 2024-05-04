import 'dart:convert';

import 'package:project_specialized_1/data/network/BaseAPIServices.dart';
import 'package:project_specialized_1/data/network/NetWorkApiServices.dart';
import 'package:project_specialized_1/model/orders_detail_model.dart';
import 'package:project_specialized_1/model/orders_model.dart';
import 'package:project_specialized_1/res/app_url.dart';

class OrdersRepository {
  BaseApiServices apiServices = NetWorkApiServices();
  Future<List<OrdersModel>> fetchOrders(int customerId) async {
    var requestData = {
      'customer_id': customerId.toString(),
    };
    final response =
        await apiServices.getPostApiResponse(AppUrl.infoOrders, requestData);

    Map<String, dynamic> data = json.decode(response.body);

    if (data['status_code'] == 200) {
      List<dynamic> jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((x) => OrdersModel.fromJson(x)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<void> cancelOrder(String orderCode) async {
    var requestData = {
      'order_code': orderCode,
    };

    final response =
        await apiServices.getPostApiResponse(AppUrl.cancelOrder, requestData);
    Map<String, dynamic> data = json.decode(response.body);

    if (data['status_code'] == 200) {
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<List<OrdersDetailModel>> detailOrder(String orderCode) async {
    var requestData = {
      'order_code': orderCode,
    };

    final response =
        await apiServices.getPostApiResponse(AppUrl.orderDetail, requestData);
    Map<String, dynamic> data = json.decode(response.body);

    if (data['status_code'] == 200) {
      List<dynamic> jsonResponse = json.decode(response.body)['data'];
      return jsonResponse
          .map((orderDetail) => OrdersDetailModel.fromJson(orderDetail))
          .toList();
    } else {
      throw Exception('Failed to load orders detail');
    }
  }
}
