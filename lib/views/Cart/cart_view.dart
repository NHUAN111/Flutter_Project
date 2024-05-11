import 'package:flutter/material.dart';
import 'package:project_specialized_1/model/cart_model.dart';
import 'package:project_specialized_1/view_model/cart_view_model.dart';
import 'package:provider/provider.dart';
import '../../constant/constant.dart';
import '../../data/LocalData/SharedPrefsManager/shared_preferences.dart';
import '../../utils/routes/routes_name.dart';
import '../../widgets/format_price.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late Future<List<CartModel>> futureCart;
  TextEditingController couponController = TextEditingController();
  double total = 0;
  int countCart = 0;
  bool hasItemsInCart = false;
  bool checkCoupon = false;
  String couponCode = '';
  late List<CartModel> cartItems = [];

  @override
  void initState() {
    loadCartData();
    super.initState();
  }

  void loadCartData() async {
    final viewModel = Provider.of<CartViewModel>(context, listen: false);
    final savedUser = SharedPrefsManager.getData(Constant.USER_PREFERENCES);
    setState(() {
      futureCart = viewModel.listAllCart(savedUser!.customerId!);
    });
    final cartItemsData = await viewModel.listAllCart(savedUser!.customerId!);
    setState(() {
      cartItems = cartItemsData;
      countCart = cartItems.length;
    });

    if (cartItems.isNotEmpty) {
      setState(() {
        hasItemsInCart = true;
      });
    } else {
      setState(() {
        hasItemsInCart = false;
      });
    }

    //Check coupon
    final coupon =
        SharedPrefsManager.getDataCoupon(Constant.COUPON_PREFERENCES);
    if (coupon?.couponCode != null) {
      setState(() {
        checkCoupon = true;
        couponCode = coupon!.couponCode;
      });
    } else {
      setState(() {
        checkCoupon = false;
      });
    }
  }

  Future<void> onDeleteCart(int id, int customerId) async {
    final viewModel = Provider.of<CartViewModel>(context, listen: false);
    await viewModel.deleteCart(id, customerId);
    total = calculateTotal(cartItems);
    loadCartData(); // Cập nhật lại giỏ hàng sau khi xóa mục
  }

  Future<void> onUpdateQty(int foodId, int customerId, int quantity) async {
    final viewModel = Provider.of<CartViewModel>(context, listen: false);
    await viewModel.updateCart(foodId, customerId, quantity);
    total = calculateTotal(cartItems);
    // loadCartData(); // Cập nhật lại giỏ hàng sau khi cập nhật số lượng
  }

  Future<void> updateCoupon() async {
    calculateTotal(cartItems);
    loadCartData();
  }

  double calculateTotal(List<CartModel> cartItems) {
    double total = 0;
    final coupon =
        SharedPrefsManager.getDataCoupon(Constant.COUPON_PREFERENCES);

    for (var item in cartItems) {
      total += double.parse(item.price.replaceAll(',', '')) * item.quantity;
    }

    if (coupon?.couponCode != null) {
      if (coupon?.couponCondition == 1) {
        double totalCoupon = total * coupon!.couponNumber / 100;
        total -= totalCoupon;
      } else if (coupon?.couponCondition == 2) {
        total -= coupon!.couponNumber;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ Hàng ($countCart)'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          loadCartData();
        },
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<CartModel>>(
                  future: futureCart,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Đã xảy ra lỗi: ${snapshot.error}');
                    } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                      return Image.asset(
                        'assets/images/empty-cart.png',
                        width: 180,
                        height: 220,
                      );
                    } else {
                      return ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final CartModel item = cartItems[index];
                          String totalPrice =
                              (double.parse(item.price.replaceAll(',', '')) *
                                      item.quantity)
                                  .toString();

                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10),
                            child: Card(
                              elevation: 2,
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Container(
                                    height: 130,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(item.imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: 150,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 30),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            PriceFormatter
                                                .formatPriceFromString(
                                                    item.price),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.remove),
                                                onPressed: () {
                                                  setState(() {
                                                    if (item.quantity > 1) {
                                                      item.quantity--;
                                                      onUpdateQty(
                                                          item.idFood,
                                                          item.customerId,
                                                          item.quantity);
                                                    }
                                                  });
                                                },
                                              ),
                                              Text(
                                                '${item.quantity}',
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.add),
                                                onPressed: () {
                                                  setState(() {
                                                    item.quantity++;
                                                    onUpdateQty(
                                                        item.idFood,
                                                        item.customerId,
                                                        item.quantity);
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 82,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              onDeleteCart(
                                                  item.idFood, item.customerId);
                                            },
                                            icon: const Icon(
                                              Icons.close_rounded,
                                              size: 30.0,
                                              color: Color.fromARGB(
                                                  255, 241, 56, 43),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 40,
                                          ),
                                          Text(
                                            PriceFormatter
                                                .formatPriceFromString(
                                                    totalPrice),
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Mã giảm: ${checkCoupon ? couponCode : 'Trống'}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (hasItemsInCart) {
                              Navigator.pushNamed(context, RoutesName.coupon);
                              await SharedPrefsManager.init();
                              await SharedPrefsManager.removeData(
                                  Constant.COUPON_PREFERENCES);
                              updateCoupon();
                            }
                          },
                          child: Text(
                            'Chọn mã giảm >',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color:
                                  hasItemsInCart ? Colors.black : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tổng (tạm tính): ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' ${PriceFormatter.formatPriceFromString(total.toStringAsFixed(2))}',
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
                        backgroundColor: hasItemsInCart
                            ? const Color.fromARGB(255, 249, 75, 63)
                            : Colors.grey,
                        textStyle: const TextStyle(
                          fontSize: 22,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        // Qua trang chi tiet thanh toan
                        if (hasItemsInCart) {
                          Navigator.pushNamed(context, RoutesName.checkout);
                        }
                      },
                      child: const Text(
                        'Đặt Đơn',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
