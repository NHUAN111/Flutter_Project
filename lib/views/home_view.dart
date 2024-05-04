import 'package:flutter/material.dart';
import 'package:project_specialized_1/utils/routes/routes_name.dart';
import 'package:project_specialized_1/views/Category/category_view%20.dart';
import 'package:project_specialized_1/views/Favourite/favourite_view.dart';
import 'package:project_specialized_1/views/Food/food_all_view.dart';
import 'package:project_specialized_1/views/Food/food_best_seller_view.dart';
import 'package:project_specialized_1/views/Food/food_discount_view.dart';
import 'package:project_specialized_1/views/Food/food_new_view.dart';
import 'package:project_specialized_1/views/Slider/slider_view.dart';

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
    const FavouroteViewPage(),
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
                Navigator.pushNamed(context, RoutesName.cart);
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
    return const Center(
      child: Text('Cá nhân'),
    );
  }
}
