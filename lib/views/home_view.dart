import 'package:flutter/material.dart';
import 'package:project_specialized_1/utils/routes/routes_name.dart';
import 'package:project_specialized_1/views/Category/category_view%20.dart';
import 'package:project_specialized_1/views/Favourite/favourite_view.dart';
import 'package:project_specialized_1/views/Food/food_all_view.dart';
import 'package:project_specialized_1/views/Food/food_best_seller_view.dart';
import 'package:project_specialized_1/views/Food/food_discount_view.dart';
import 'package:project_specialized_1/views/Food/food_new_view.dart';
import 'package:project_specialized_1/views/Profile/profile_view.dart';
import 'package:project_specialized_1/views/Slider/slider_view.dart';
import 'package:provider/provider.dart';

import '../constant/constant.dart';
import '../data/LocalData/SharedPrefsManager/shared_preferences.dart';
import '../model/cart_model.dart';
import '../view_model/cart_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  late List<CartModel> cartItems = [];

  // Check hien thi appbar
  bool _showAppBar = true;

  @override
  void initState() {
    super.initState();
    // Đăng ký một người nghe để lắng nghe sự thay đổi trong giỏ hàng
    Provider.of<CartViewModel>(context, listen: false).addListener(updateCart);
    // Tải số lượng giỏ hàng ban đầu
    loadQtyCart();
  }

  // Hàm này được gọi mỗi khi có thay đổi trong giỏ hàng
  void updateCart() {
    loadQtyCart();
  }

  void loadQtyCart() async {
    final viewModel = Provider.of<CartViewModel>(context, listen: false);
    final savedUser = SharedPrefsManager.getData(Constant.USER_PREFERENCES);

    final cartItemsData = await viewModel.listAllCart(savedUser!.customerId!);
    setState(() {
      cartItems = cartItemsData;
    });
  }

  @override
  void dispose() {
    // Hủy đăng ký người nghe khi widget bị hủy
    Provider.of<CartViewModel>(context, listen: false)
        .removeListener(updateCart);
    super.dispose();
  }

  // Các trang view tương ứng với mỗi tab
  final List<Widget> _pages = [
    const HomeViewPage(),
    const CategoriesViewPage(),
    const FavouroteViewPage(),
    const ProfileViewPage(),
  ];

  @override
  Widget build(BuildContext context) {
    int countCart = cartItems.length;
    return Scaffold(
      appBar: _showAppBar
          ? AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/images/logo-app.png',
                    width: 80,
                    height: 120,
                  ),
                  // const SizedBox(width: ), // Khoảng cách giữa logo và ô tìm kiếm
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Tìm kiếm...',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.cart);
                    },
                    icon: Stack(
                      children: [
                        const Icon(
                          Icons.shopping_cart,
                          size: 32,
                        ),
                        if (countCart > 0)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 18,
                                minHeight: 18,
                              ),
                              child: Text(
                                '$countCart',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : null,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Danh mục',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Yêu thích',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Cá nhân',
          ),
        ],
      ),
    );
  }

  // Hàm xử lý khi tab được chọn
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _showAppBar = index != 2 && index != 3 && index != 1;
    });
  }
}

// Các view tương ứng với mỗi tab
class HomeViewPage extends StatelessWidget {
  const HomeViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          SliderView(),
          SizedBox(height: 5),
          // View comming soon
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: Text(
                  'Gợi Ý Cho Bạn ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // FoodBestSellerView
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: Text(
                  'Bán Chạy Nhất ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FoodBestSellerView(),

              // Food New
              SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: Text(
                  'Món Mới ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FoodNewView(),

              // Food Discount
              SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: Text(
                  'Món Giảm Giá ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FoodDiscountView(),

              // All Food
              SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Tất Cả Món',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 140),
                      Text(
                        'Xem tất cả >',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 241, 56, 43),
                        ),
                      ),
                    ],
                  ),
                  FoodAllView(),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CategoriesViewPage extends StatelessWidget {
  const CategoriesViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CategoriesView(),
    );
  }
}

class FavouroteViewPage extends StatelessWidget {
  const FavouroteViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FavouriteView(),
    );
  }
}

class ProfileViewPage extends StatelessWidget {
  const ProfileViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileView(),
    );
  }
}
