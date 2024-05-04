import 'package:project_specialized_1/model/orders_detail_model.dart';
import 'package:project_specialized_1/model/payment_model.dart';
import 'package:project_specialized_1/model/shipping_model.dart';

class OrdersModel {
  String? orderCode;
  String? orderCoupon;
  String? orderFeeShip;
  String? couponPrice;
  int? customerId;
  int? shippingId;
  int? paymentId;
  int? orderStatus;
  String? createdAt;
  // String? updatedAt;
  List<OrdersDetailModel>? orderDetail;
  ShippingModel? shippingDetail;
  PaymentModel? paymentDetail;

  OrdersModel({
    this.orderCode,
    this.orderCoupon,
    this.couponPrice,
    this.orderFeeShip,
    this.customerId,
    this.shippingId,
    this.paymentId,
    this.orderStatus,
    this.createdAt,
    //  this.updatedAt,
    this.shippingDetail,
    this.paymentDetail,
    this.orderDetail,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      orderCode: json['order_code'] as String?,
      orderCoupon: json['order_coupon'] as String?,
      orderFeeShip: json['order_feeship'] as String?,
      couponPrice: json['coupon_price'] as String?,
      customerId: json['customer_id'] as int?,
      shippingId: json['shipping_id'] as int?,
      paymentId: json['payment_id'] as int?,
      orderStatus: json['order_status'] as int?,
      createdAt: json['created_at'] as String?,
      orderDetail: (json['order_detail'] as List<dynamic>?)
          ?.map((orderDetail) => OrdersDetailModel.fromJson(orderDetail))
          .toList(),
      shippingDetail: json['shipping_detail'] != null
          ? ShippingModel.fromJson(json['shipping_detail'])
          : null,
      paymentDetail: json['payment_detail'] != null
          ? PaymentModel.fromJson(json['payment_detail'])
          : null,
    );
  }
}
