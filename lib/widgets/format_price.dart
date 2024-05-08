import 'package:intl/intl.dart';

class PriceFormatter {
  static String formatPriceFromString(String priceString) {
    // Chuyển đổi giá trị chuỗi thành số
    double price = double.tryParse(priceString) ?? 0.0;

    // Định dạng giá tiền
    final formatter = NumberFormat.currency(
      locale: 'vi', // Chọn ngôn ngữ và đơn vị tiền tệ  ở đây
      symbol: 'đ',
    );

    return formatter.format(price);
  }
}
