import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_specialized_1/model/user_model.dart';
import 'package:project_specialized_1/repository/auth_repository.dart';
import 'package:project_specialized_1/utils/routes/routes_name.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = Authrepository();

  Future<void> loginUser(
      String name, String password, BuildContext context) async {
    try {
      await _myRepo.loginUser(name, password);
      print('Đăng nhập thành công');
      Navigator.pushNamed(context, RoutesName.home);
    } catch (error) {
      print('Đăng nhập thất bại: $error');
      if (kDebugMode) {
        print(error.toString());
      }
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng nhập không thành công. Vui lòng thử lại.'),
        ),
      );
    }
  }

  Future<void> registerUser(UserModel userModel, BuildContext context) async {
    try {
      await _myRepo.registerUser(userModel);
      print('Đăng ký thành công');
      Navigator.pushNamed(context, RoutesName.home);
    } catch (error) {
      print('Đăng ký thất bại: $error');
      if (kDebugMode) {
        print(error.toString());
      }
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng ký không thành công. Vui lòng thử lại.'),
        ),
      );
    }
  }
}
