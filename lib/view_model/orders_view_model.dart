import 'package:flutter/material.dart';
import 'package:project_specialized_1/model/cart_model.dart';
import 'package:project_specialized_1/model/orders_detail_model.dart';
import 'package:project_specialized_1/model/orders_model.dart';
import 'package:project_specialized_1/model/user_model.dart';
import 'package:project_specialized_1/repository/orders_repository.dart';
import 'package:toastification/toastification.dart';

import '../widgets/toast.dart';

class OrdersViewModel with ChangeNotifier {
  final OrdersRepository _repository = OrdersRepository();
  List<OrdersModel> _order = [];
  List<OrdersModel> get orders => _order;

  //Order detail
  List<OrdersDetailModel> _orderDetail = [];
  List<OrdersDetailModel> get ordersDetail => _orderDetail;

  Future<List<OrdersModel>> fechOrders(int customerId) async {
    try {
      _order = await _repository.fetchOrders(customerId);
      notifyListeners();
      return _order;
    } catch (e) {
      print('Error fetching orders: $e');
      rethrow;
    }
  }

  //Order detail
  Future<List<OrdersDetailModel>> fechOrderDetail(String orderCode) async {
    try {
      _orderDetail = await _repository.detailOrder(orderCode);
      notifyListeners();
      return _orderDetail;
    } catch (e) {
      print('Error fetching orders detail: $e');
      rethrow;
    }
  }

  Future<void> cancelOrder(String orderCode) async {
    try {
      await _repository.cancelOrder(orderCode);
      notifyListeners();
    } catch (e) {
      print('Error cancel order: $e');
      rethrow;
    }
  }

  Future<void> order(
      UserModel userModel,
      String address,
      int paymentMethod,
      int couponPrice,
      String orderCoupon,
      int orderFeeship,
      String cartList) async {
    try {
      await _repository.order(userModel, address, paymentMethod, couponPrice,
          orderCoupon, orderFeeship, cartList);
      notifyListeners();
    } catch (e) {
      print('Error order: $e');
      rethrow;
    }
  }
}
