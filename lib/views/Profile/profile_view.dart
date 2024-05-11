import 'package:flutter/material.dart';
import 'package:project_specialized_1/constant/constant.dart';
import 'package:project_specialized_1/data/LocalData/SharedPrefsManager/shared_preferences.dart';
import 'package:project_specialized_1/utils/routes/routes_name.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  final savedUser = SharedPrefsManager.getData(Constant.USER_PREFERENCES);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/user.png',
                  width: 100,
                  height: 140,
                ),
                Text(
                  'Xin Chào ${savedUser!.customerName}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Text("Junior Product Designer")
              ],
            ),
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.order);
                },
                child: const Card(
                  elevation: 4,
                  shadowColor: Colors.black12,
                  child: ListTile(
                    leading: Icon(
                      Icons.shopping_basket_sharp,
                    ),
                    title: Text('Đơn Hàng Của Bạn'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.addressDelivery);
                },
                child: const Card(
                  elevation: 4,
                  shadowColor: Colors.black12,
                  child: ListTile(
                    leading: Icon(
                      Icons.map,
                    ),
                    title: Text('Địa Chỉ Giao Hàng'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.cart);
                },
                child: const Card(
                  elevation: 4,
                  shadowColor: Colors.black12,
                  child: ListTile(
                    leading: Icon(
                      Icons.shopping_bag,
                    ),
                    title: Text('Giỏ Hàng'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              height: 20,
              indent: 5,
              endIndent: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, RoutesName.cart);
                },
                child: const Card(
                  elevation: 4,
                  shadowColor: Colors.black12,
                  child: ListTile(
                    leading: Icon(
                      Icons.logout_rounded,
                    ),
                    title: Text('Đăng Xuất'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
