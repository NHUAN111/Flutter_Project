import 'dart:convert';

import 'package:project_specialized_1/data/network/BaseAPIServices.dart';
import 'package:project_specialized_1/data/network/NetWorkApiServices.dart';
import 'package:project_specialized_1/model/cart_model.dart';
import 'package:project_specialized_1/model/orders_detail_model.dart';
import 'package:project_specialized_1/model/orders_model.dart';
import 'package:project_specialized_1/model/user_model.dart';
import 'package:project_specialized_1/res/app_url.dart';

class OrdersRepository {
  BaseApiServices apiServices = NetWorkApiServices();

  Future<void> order(
      UserModel userModel,
      String address,
      int paymentMethod,
      int couponPrice,
      String orderCoupon,
      int orderFeeship,
      String cartList) async {
    var requestData = {
      'customer_id': userModel.customerId.toString(),
      'customer_name': userModel.customerName,
      'customer_address': address,
      'customer_phone': userModel.customerPhone,
      'customer_email': userModel.customerEmail,
      'payment_method': paymentMethod.toString(),
      'coupon_price': couponPrice.toString(),
      'order_coupon': orderCoupon,
      'order_feeship': orderFeeship.toString(),
      'cart': cartList,
    };
    try {
      print('2');
      final response =
          await apiServices.getPostApiResponse(AppUrl.order, requestData);
      Map<String, dynamic> data = json.decode(response.body);
      print('1');
      if (data['status_code'] == 200) {
        print('Order success');
      } else {
        print(
            'Failed to order: ${data['message']}'); // In ra thông báo lỗi từ phản hồi API
      }
    } catch (e) {
      print('Error: $e'); // In ra thông báo lỗi nếu có
      throw Exception('Failed to orders');
    }
  }

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
