import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_specialized_1/constant/constant.dart';
import 'package:project_specialized_1/data/LocalData/SharedPrefsManager/shared_preferences.dart';
import 'package:project_specialized_1/data/LocalData/SqfLite/CartLocalData.dart';
import 'package:project_specialized_1/model/cart_model.dart';
import 'package:project_specialized_1/model/user_model.dart';
import 'package:project_specialized_1/utils/routes/routes_name.dart';
import 'package:project_specialized_1/view_model/cart_view_model.dart';
import 'package:project_specialized_1/view_model/orders_view_model.dart';
import 'package:project_specialized_1/widgets/format_price.dart';
import 'package:project_specialized_1/widgets/toast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  _CheckoutViewState createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  late Future<List<CartModel>> futureCart;
  late List<CartModel> cartItems = [];
  List<String> list = ['Thanh Toán Tiền Mặt', 'Thanh Toán Bằng Thẻ'];
  String? dropdownValue;

  // Check fee
  bool checkFee = false;

  // Thong tin khach hang
  String customerName = '';
  String customerPhone = '';
  String customerAddress = '';

  // Tong gia tien thanh toan
  double total = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  double calculateTotal(List<CartModel> cartItems) {
    double total = 0;
    final feeship =
        SharedPrefsManager.getDataFeeship(Constant.FEESHIP_PREFERENCES);
    final coupon =
        SharedPrefsManager.getDataCoupon(Constant.COUPON_PREFERENCES);

    for (var item in cartItems) {
      total += double.parse(item.price.replaceAll(',', '')) * item.quantity;
    }

    if (coupon?.couponCode != null) {
      if (coupon?.couponCondition == 1) {
        double totalCoupon = total * coupon!.couponNumber / 100;
        total = (total - totalCoupon) + feeship!.feeship;
      } else if (coupon?.couponCondition == 2) {
        total = (total - coupon!.couponNumber) + feeship!.feeship;
      }
    } else {
      total = total + feeship!.feeship;
    }
    return total;
  }

  void loadData() async {
    final user = SharedPrefsManager.getData(Constant.USER_PREFERENCES);
    final viewModel = Provider.of<CartViewModel>(context, listen: false);
    futureCart = viewModel.listAllCart(user!.customerId!);
    final feeship =
        SharedPrefsManager.getDataFeeship(Constant.FEESHIP_PREFERENCES);

    final cartItemsData = await viewModel.listAllCart(user.customerId!);
    setState(() {
      cartItems = cartItemsData;
      total = calculateTotal(cartItems);
    });

    if (feeship != null) {
      setState(() {
        checkFee = true;
        customerName = feeship.customerName!;
        customerPhone = feeship.customerPhone!;
        customerAddress = feeship.address!;
      });
    } else {
      setState(() {
        checkFee = false;
        customerName = '';
        customerPhone = '';
        customerAddress = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi Tiết Thanh Toán'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          loadData();
        },
        child: Center(
          child: Column(
            children: [
              Container(
                color: const Color.fromARGB(255, 255, 239, 230),
                child: const Padding(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Color.fromARGB(255, 255, 127, 67),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'Trước khi đặt hàng, hãy đảm bảo địa chỉ chính xác và phù hợp với địa chỉ hiện tại của bạn.',
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 14),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add_location_alt_rounded,
                          color: Color.fromARGB(255, 255, 102, 91),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    checkFee ? customerName : 'Người Nhận',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 60),
                                  Text(
                                    checkFee
                                        ? '(+84) $customerPhone'
                                        : '(Chưa xác định)',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 96, 96, 96),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                checkFee
                                    ? customerAddress
                                    : 'Địa chỉ người nhận (vui lòng chọn thông tin)',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Xu ly
                            SharedPrefsManager.init();
                            SharedPrefsManager.removeData(
                                Constant.FEESHIP_PREFERENCES);
                            Navigator.pushNamed(
                                    context, RoutesName.addressDelivery)
                                .then((value) {
                              loadData();
                              // }
                            });
                          },
                          icon: const Icon(
                            Icons.navigate_next_rounded,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              FutureBuilder<List<CartModel>>(
                future: futureCart,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    final List<CartModel> cartItems = snapshot.data!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          '    Sản Phẩm Đã Chọn',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 260,
                          child: ListView.builder(
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              final item = cartItems[index];
                              String totalPrice = (double.parse(
                                          item.price.replaceAll(',', '')) *
                                      item.quantity)
                                  .toString();
                              return Container(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 10, left: 20, right: 20),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    // color: const Color.fromARGB(
                                    //     255, 241, 241, 241),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            8), // Rounded corners
                                        child: Image.network(
                                          item.imageUrl,
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            PriceFormatter.formatPriceFromString(
                                                totalPrice), // Assuming PriceFormatter is a helper class
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 89, 77),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${item.quantity}x',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: DropdownMenu<String>(
                            width: 375,
                            initialSelection: list.first,
                            onSelected: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                                print(dropdownValue);
                              });
                            },
                            dropdownMenuEntries: list
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(
                                  value: value, label: value);
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tổng thanh toán',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '(đã có phí vận chuyển)',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    PriceFormatter.formatPriceFromString(
                                        total.toString()),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: checkFee
                                      ? const Color.fromARGB(255, 249, 75, 63)
                                      : Colors.grey,
                                  textStyle: const TextStyle(
                                    fontSize: 22,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () async {
                                  // Qua thanh toan gui len server
                                  if (checkFee) {
                                    print('check ');
                                    final user = SharedPrefsManager.getData(
                                        Constant.USER_PREFERENCES);
                                    final feeShip =
                                        SharedPrefsManager.getDataFeeship(
                                            Constant.FEESHIP_PREFERENCES);
                                    final coupon =
                                        SharedPrefsManager.getDataCoupon(
                                            Constant.COUPON_PREFERENCES);
                                    final viewModel =
                                        Provider.of<CartViewModel>(context,
                                            listen: false);
                                    final cartItemsData = await viewModel
                                        .listAllCart(user!.customerId!);
                                    late List<CartModel> cartItems = [];
                                    cartItems = cartItemsData;
                                    int paymentMethod;
                                    String address, jsonCartList, orderCoupon;
                                    int fee, couponPrice;
                                    if (dropdownValue ==
                                        'Thanh Toán Tiền Mặt') {
                                      print('ok');
                                      UserModel userModel = UserModel(
                                        customerId: user.customerId,
                                        customerName: user.customerName,
                                        customerPhone: user.customerPhone,
                                        customerEmail: user.customerEmail,
                                      );
                                      address = feeShip!.address!;
                                      paymentMethod = 1;
                                      if (coupon == null) {
                                        couponPrice = 0;
                                        orderCoupon = '0';
                                      } else {
                                        couponPrice = coupon.couponNumber;
                                        orderCoupon = coupon.couponCode;
                                      }

                                      fee = feeShip.feeship;
                                      // Mã hóa danh sách carts thành chuỗi JSON
                                      jsonCartList = jsonEncode(cartItems
                                          .map((cart) => cart.toJson())
                                          .toList());
                                      print(
                                          'User ${userModel.customerId}${userModel.customerName}${userModel.customerEmail}${userModel.customerPhone}');
                                      print(
                                          'coupon_price: $couponPrice, order_feeship: $fee, address$address'
                                          ', ');
                                      print('orderCoupon$orderCoupon');
                                      print(fee);
                                      print(jsonCartList);
                                      final viewModel =
                                          Provider.of<OrdersViewModel>(context,
                                              listen: false);
                                      viewModel.order(
                                          userModel,
                                          address,
                                          paymentMethod,
                                          couponPrice,
                                          orderCoupon,
                                          fee,
                                          jsonCartList);
                                      print('TT DON KHI NHAN HANG');
                                      BaseToast.showSuccess(context,
                                          'Thành công', 'Đặt hàng thành công');
                                      // Xoa het thong tin khi dat hang thanh cong
                                      final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs
                                          .remove(Constant.FEESHIP_PREFERENCES);

                                      // prefs.remove(Constant.COUPON_PREFERENCES);
                                      DatabaseHelper databaseHelper =
                                          DatabaseHelper();
                                      await databaseHelper.deleteAllData();
                                      Navigator.pushReplacementNamed(
                                          context, RoutesName.home);
                                    } else if (dropdownValue ==
                                        'Thanh Toán Bằng Thẻ') {
                                      print('ok');
                                      UserModel userModel = UserModel(
                                        customerId: user.customerId,
                                        customerName: user.customerName,
                                        customerPhone: user.customerPhone,
                                        customerEmail: user.customerEmail,
                                      );
                                      address = feeShip!.address!;
                                      paymentMethod = 2;
                                      if (coupon == null) {
                                        couponPrice = 0;
                                        orderCoupon = '0';
                                      } else {
                                        couponPrice = coupon.couponNumber;
                                        orderCoupon = coupon.couponCode;
                                      }
                                      fee = feeShip.feeship;
                                      // Mã hóa danh sách carts thành chuỗi JSON
                                      jsonCartList = jsonEncode(cartItems
                                          .map((cart) => cart.toJson())
                                          .toList());
                                      print(
                                          'User ${userModel.customerId}${userModel.customerName}${userModel.customerEmail}${userModel.customerPhone}');
                                      print(
                                          'coupon_price: $couponPrice, order_feeship: $fee, address$address');
                                      print('orderCoupon$orderCoupon');
                                      print(fee);
                                      print(jsonCartList);
                                      final viewModel =
                                          Provider.of<OrdersViewModel>(context,
                                              listen: false);
                                      viewModel.order(
                                          userModel,
                                          address,
                                          paymentMethod,
                                          couponPrice,
                                          orderCoupon,
                                          fee,
                                          jsonCartList);
                                      print('TT ONLINE QUA MOMO');
                                      BaseToast.showSuccess(context,
                                          'Thành công', 'Đặt hàng thành công');
                                      // Xoa het thong tin khi dat hang thanh cong
                                      final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs
                                          .remove(Constant.FEESHIP_PREFERENCES);
                                      // prefs.remove(Constant.COUPON_PREFERENCES);
                                      DatabaseHelper databaseHelper =
                                          DatabaseHelper();
                                      await databaseHelper.deleteAllData();
                                      Navigator.pushReplacementNamed(
                                          context, RoutesName.home);
                                    }
                                  }
                                },
                                child: const Text(
                                  'Thanh Toán',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
