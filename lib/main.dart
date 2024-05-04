import 'package:flutter/material.dart';
import 'package:project_specialized_1/constant/constant.dart';
import 'package:project_specialized_1/data/LocalData/SharedPrefsManager/shared_preferences.dart';
import 'package:project_specialized_1/data/LocalData/SqfLite/CartLocalData.dart';
import 'package:project_specialized_1/utils/routes/routes.dart';
import 'package:project_specialized_1/utils/routes/routes_name.dart';
import 'package:project_specialized_1/view_model/cart_view_model.dart';
import 'package:project_specialized_1/view_model/coupon_view_model.dart';
import 'package:project_specialized_1/view_model/food_view_model.dart';
import 'package:project_specialized_1/view_model/auth_view_model.dart';
import 'package:project_specialized_1/view_model/category_view_model.dart';
import 'package:project_specialized_1/view_model/orders_view_model.dart';
import 'package:project_specialized_1/view_model/slider_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Khởi tạo SharedPreferences trước khi chạy ứng dụng
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsManager.init();
  // Obtain shared preferences.
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(Constant.COUPON_PREFERENCES);
  // Khởi tạo đối tượng DatabaseHelper
  DatabaseHelper databaseHelper = DatabaseHelper();

  // Xóa hết dữ liệu trong bảng 'cart'
  await databaseHelper.deleteAllData();

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
  late SliderViewModel _sliderViewModel;
  late FoodViewModel _foodViewModel;
  late CartViewModel _cartViewModel;
  late CouponViewModel _couponViewModel;
  late OrdersViewModel _ordersViewModel;

  @override
  void initState() {
    super.initState();
    _authViewModel = AuthViewModel();
    _categoryViewModel = CategoryViewModel();
    _sliderViewModel = SliderViewModel();
    _foodViewModel = FoodViewModel();
    _cartViewModel = CartViewModel();
    _couponViewModel = CouponViewModel();
    _ordersViewModel = OrdersViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _authViewModel),
        ChangeNotifierProvider.value(value: _categoryViewModel),
        ChangeNotifierProvider.value(value: _sliderViewModel),
        ChangeNotifierProvider.value(value: _foodViewModel),
        ChangeNotifierProvider.value(value: _cartViewModel),
        ChangeNotifierProvider.value(value: _couponViewModel),
        ChangeNotifierProvider.value(value: _ordersViewModel),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: RoutesName.order,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
