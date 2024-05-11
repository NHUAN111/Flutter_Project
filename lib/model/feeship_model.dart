class FeeshipModel {
  int? customerId;
  late int feeship;
  String? address;
  int? statusFee;
  String? customerName;
  String? customerPhone;

  FeeshipModel({
    this.customerId,
    required this.feeship,
    this.address,
    this.statusFee,
    this.customerName,
    this.customerPhone,
  });

  factory FeeshipModel.fromJson(Map<String, dynamic> json) {
    return FeeshipModel(
      customerId: json['customerId'],
      feeship: json['fee_feeship'],
      address: json['address'].toString(),
      statusFee: json['statusFee'],
      customerName: json['customerName'].toString(),
      customerPhone: json['customerPhone'].toString(),
    );
  }

  void updateStatus(int status) {
    statusFee = status;
  }

  Map<String, dynamic> toJson() {
    return {
      'fee_feeship': feeship,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'fee_feeship': feeship,
      'address': address,
      'statusFee': statusFee,
      'customerName': customerName,
      'customerPhone': customerPhone,
    };
  }
}
