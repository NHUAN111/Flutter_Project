import 'package:flutter/material.dart';
import 'package:project_specialized_1/view/Category/category_view%20.dart';
import 'package:project_specialized_1/view/Food/food_all_view.dart';
import 'package:project_specialized_1/view/Food/food_best_seller_view.dart';
import 'package:project_specialized_1/view/Food/food_discount_view.dart';
import 'package:project_specialized_1/view/Food/food_new_view.dart';
import 'package:project_specialized_1/view/Slider/slider_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  // Các trang view tương ứng với mỗi tab
  final List<Widget> _pages = [
    const HomeViewPage(),
    const CategoriesViewPage(),
    const CartViewPage(),
    const ProfileViewPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const FlutterLogo(size: 30), // Logo Flutter
            const SizedBox(width: 20), // Khoảng cách giữa logo và ô tìm kiếm
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
                // Xử lý khi nhấn vào icon giỏ hàng
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ],
        ),
      ),
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
            icon: Icon(Icons.shopping_bag),
            label: 'Giỏ hàng',
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
                  'GỢI Ý CHO BẠN ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          // View Food best seller
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: Text(
                  'BÁN CHẠY NHẤT ', // Tiêu đề cho FoodBestSellerView
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FoodBestSellerView(), // Widget tiếp theo sau SliderView
            ],
          ),
          SizedBox(height: 20),

          // View food new
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: Text(
                  'MÓN MỚI ', // Tiêu đề cho FoodBestSellerView
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FoodNewView(), // Widget tiếp theo sau SliderView
            ],
          ),

          // View food discount
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: Text(
                  'MÓN GIẢM GIÁ ', // Tiêu đề cho FoodBestSellerView
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FoodDiscountView(), // Widget tiếp theo sau SliderView
            ],
          ),
          // View food all
          SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'TẤT CẢ MÓN',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 140),
                  Text(
                    'Xem tất cả',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
              FoodAllView(),
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
      body:
          CategoriesView(), // Nhúng CategoriesView vào trong body của CategoriesViewPage
    );
  }
}

class CartViewPage extends StatelessWidget {
  const CartViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Giỏ hàng'),
    ); // Thay thế Center(child: Text('Đơn hàng')) bằng OrderPage()
  }
}

class ProfileViewPage extends StatelessWidget {
  const ProfileViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Cá nhân'),
    );
  }
}
