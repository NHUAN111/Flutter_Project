import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_specialized_1/constant/constant.dart';
import 'package:project_specialized_1/data/LocalData/SharedPrefsManager/shared_preferences.dart';
import 'package:project_specialized_1/utils/routes/routes_name.dart';
import 'package:project_specialized_1/views/Category/category_view%20.dart';
import 'package:project_specialized_1/views/Category/category_view_home.dart';
import 'package:project_specialized_1/views/Favourite/favourite_view.dart';
import 'package:project_specialized_1/views/Food/food_all_view.dart';
import 'package:project_specialized_1/views/Food/food_best_seller_view.dart';
import 'package:project_specialized_1/views/Food/food_discount_view.dart';
import 'package:project_specialized_1/views/Food/food_new_view.dart';
import 'package:project_specialized_1/views/Profile/profile_view.dart';
import 'package:project_specialized_1/views/Slider/slider_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  // Check hien thi appbar
  bool _showAppBar = true;

  final savedUser = SharedPrefsManager.getData(Constant.USER_PREFERENCES);

  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      appBar: _showAppBar
          ? AppBar(
              toolbarHeight: 140,
              backgroundColor: const Color.fromARGB(255, 255, 60, 60),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              title: Padding(
                padding:
                    const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Xin Chào ${savedUser!.customerName!.toString()} !',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Welcome To Fast Food',
                              style: TextStyle(
                                fontSize: 21,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                shape: BoxShape.rectangle,
                                color: const Color.fromARGB(255, 240, 204, 201)
                                    .withOpacity(0.5),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, RoutesName.cart);
                                },
                                icon: const Icon(
                                  Icons.shopping_bag,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                shape: BoxShape.rectangle,
                                color: const Color.fromARGB(255, 240, 204, 201)
                                    .withOpacity(0.5),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Image.asset(
                        //   'assets/images/restaurant.png',
                        //   width: 60,
                        //   height: 60,
                        // ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 234, 234, 234),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      // padding: const EdgeInsets.only(left: 4),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Tìm kiếm...',
                          border: InputBorder.none,
                          icon: IconButton(
                            onPressed: () {
                              //
                              print('ok');
                            },
                            icon: const Icon(
                              Icons.search,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book),
            label: 'Danh mục',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Yêu thích',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
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
      body: Container(
        color: Colors.grey[200],
        child: ListView(
          children: const [
            SliderView(),
            SizedBox(height: 4),
            // View comming soon
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  child: Text(
                    'Danh Mục ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CategoryHomeView(),

                // FoodBestSellerView
                SizedBox(height: 12),
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
