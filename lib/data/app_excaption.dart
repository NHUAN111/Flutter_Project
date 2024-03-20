class AppExcaption implements Exception {
  final _message;
  final _prefix;

  AppExcaption(this._message, this._prefix);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FechDataExcaption extends AppExcaption {
  FechDataExcaption([String? message])
      : super(message, 'Lỗi trong quá trình giao tiếp');
}

class BadRequestExcaption extends AppExcaption {
  BadRequestExcaption([String? message])
      : super(message, 'Yêu cầu không hợp lệ');
}

class UnauthorisedExcaption extends AppExcaption {
  UnauthorisedExcaption([String? message])
      : super(message, 'Yêu cầu trái phép');
}

class InvalidInputExcaption extends AppExcaption {
  InvalidInputExcaption([String? message])
      : super(message, 'Đầu vào không hợp lệ');
}
