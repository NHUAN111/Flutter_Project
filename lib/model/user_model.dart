import 'package:project_specialized_1/data/LocalData/SharedPrefsManager/base_model.dart';

class UserModel extends BaseModel {
  int? customerId;
  String? customerName;
  String? customerEmail;
  String? customerPass;
  String? customerPhone;

  UserModel({
    this.customerId,
    this.customerName,
    this.customerEmail,
    this.customerPass,
    this.customerPhone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      customerId: json['customer_id'],
      customerName: json['customer_name'],
      customerEmail: json['customer_email'],
      customerPass: json['customer_pass'],
      customerPhone: json['customer_phone'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'customer_id': customerId,
      'customer_name': customerName,
      'customer_email': customerEmail,
      'customer_pass': customerPass,
      'customer_phone': customerPhone,
    };
  }
}
