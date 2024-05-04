class ShippingModel {
  int? shippingId;
  String? shippingName;
  String? shippingPhone;
  String? shippingAddress;

  ShippingModel({
    this.shippingId,
    this.shippingName,
    this.shippingPhone,
    this.shippingAddress,
  });
  factory ShippingModel.fromJson(Map<String, dynamic> json) {
    return ShippingModel(
      shippingId: json['shipping_id'],
      shippingName: json['shipping_name'],
      shippingPhone: json['shipping_phone'],
      shippingAddress: json['shipping_address'],
    );
  }
}
