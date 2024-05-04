class PaymentModel {
  final String paymentMethod;
  final String paymentStatus;

  PaymentModel({
    required this.paymentMethod,
    required this.paymentStatus,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      paymentMethod: json['payment_method'].toString(),
      paymentStatus: json['payment_status'].toString(),
    );
  }
}
