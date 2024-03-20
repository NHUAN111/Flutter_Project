import 'package:flutter/material.dart';
import 'package:project_specialized_1/view/Category/category_view%20.dart';

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
    const OrdersViewPage(),
    const FavoritesViewPage(),
    const ProfileViewPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const FlutterLogo(size: 30), // Logo Flutter
            const SizedBox(width: 10), // Khoảng cách giữa logo và ô tìm kiếm
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18), // Khoảng cách từ border đến input
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(8), // Bo tròn border của ô tìm kiếm
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm...',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets
                        .zero, // Loại bỏ padding nội dung bên trong ô tìm kiếm
                  ),
                  style:
                      TextStyle(fontSize: 14), // Điều chỉnh kích thước font chữ
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
            label: 'Đơn hàng',
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
    return ListView(
      children: const [],
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

class OrdersViewPage extends StatelessWidget {
  const OrdersViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Đơn hàng'),
    ); // Thay thế Center(child: Text('Đơn hàng')) bằng OrderPage()
  }
}

class FavoritesViewPage extends StatelessWidget {
  const FavoritesViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Yêu thích'),
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
