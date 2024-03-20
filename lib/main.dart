import 'package:flutter/material.dart';
import 'package:project_specialized_1/data/SharedPrefsManager/shared_preferences.dart';
import 'package:project_specialized_1/utils/routes/routes.dart';
import 'package:project_specialized_1/utils/routes/routes_name.dart';
import 'package:project_specialized_1/view_model/auth_view_model.dart';
import 'package:project_specialized_1/view_model/category_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  // Khởi tạo SharedPreferences trước khi chạy ứng dụng
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsManager.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthViewModel _authViewModel;
  late CategoryViewModel _categoryViewModel;

  @override
  void initState() {
    super.initState();
    _authViewModel = AuthViewModel();
    _categoryViewModel = CategoryViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _authViewModel),
        ChangeNotifierProvider.value(value: _categoryViewModel),
      ], 
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: RoutesName.home,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
