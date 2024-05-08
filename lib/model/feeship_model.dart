class FeeshipModel {
  int? customerId;
  late int feeship;
  String? address;
  int? statusFee;

  FeeshipModel({
    this.customerId,
    required this.feeship,
    this.address,
    this.statusFee,
  });

  factory FeeshipModel.fromJson(Map<String, dynamic> json) {
    return FeeshipModel(
      feeship: json['fee_feeship'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fee_feeship': feeship,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'feeship': feeship,
      'address': address,
      'statusFee': statusFee,
    };
  }
}
