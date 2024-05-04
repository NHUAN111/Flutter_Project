import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_specialized_1/model/user_model.dart';
import 'package:project_specialized_1/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerEmailController =
      TextEditingController();
  final TextEditingController _customerPassController = TextEditingController();

  final TextEditingController _customerPhoneController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng ký'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _customerNameController,
              decoration: const InputDecoration(labelText: 'Tên đăng nhập'),
            ),
            TextField(
              controller: _customerEmailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _customerPassController,
              decoration: const InputDecoration(labelText: 'Mật khẩu'),
              obscureText: true,
            ),
            TextField(
              controller: _customerPhoneController,
              decoration: const InputDecoration(labelText: 'Số điện thoại'),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                final userModel = UserModel(
                  customerName: _customerNameController.text,
                  customerEmail: _customerEmailController.text,
                  customerPass: _customerPassController.text,
                  customerPhone: _customerPhoneController.text,
                );

                final viewModel =
                    Provider.of<AuthViewModel>(context, listen: false);
                viewModel.registerUser(userModel, context);
              },
              child: const Text('Đăng ký'),
            ),
          ],
        ),
      ),
    );
  }
}
