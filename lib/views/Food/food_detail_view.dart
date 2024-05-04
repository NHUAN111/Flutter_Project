import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_specialized_1/constant/constant.dart';
import 'package:project_specialized_1/model/cart_model.dart';
import 'package:project_specialized_1/model/food_model.dart';
import 'package:project_specialized_1/view_model/cart_view_model.dart';
import 'package:project_specialized_1/view_model/food_view_model.dart';
import 'package:project_specialized_1/widgets/format_price.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodDetailView extends StatefulWidget {
  final int foodId;
  const FoodDetailView({Key? key, required this.foodId}) : super(key: key);

  @override
  _FoodDetailViewState createState() => _FoodDetailViewState();
}

class _FoodDetailViewState extends State<FoodDetailView> {
  late CartModel cartModel;
  late Future<FoodModel?> futureFood;
  late Future<List<FoodModel>?> futureFoodSame;
  late FoodModel? foodDetail; // Biến instance để lưu trữ foodDetail

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<FoodViewModel>(context, listen: false);

    futureFoodSame = viewModel.foodSameCategory(widget.foodId);

    futureFood = viewModel.foodDetail(widget.foodId).then((value) {
      setState(() {
        foodDetail = value;
      });
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<FoodModel?>(
          future: futureFood,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              if (foodDetail != null) {
                return Column(
                  children: [
                    Card(
                      color: Colors.white,
                      clipBehavior: Clip.hardEdge,
                      elevation: 5,
                      child: Image.network(
                        foodDetail!.foodImg,
                        height: 320,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                foodDetail!.foodName,
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'TAT - ĐN',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                PriceFormatter.formatPriceFromString(
                                    foodDetail!.foodPrice),
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${foodDetail!.totalOrders} đã bán',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 241, 56, 43),
                        minimumSize: const Size(350, 46),
                        elevation: 3,
                      ),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        String? userData =
                            prefs.getString(Constant.USER_PREFERENCES);
                        int? idCustomer;
                        if (userData != null) {
                          Map<String, dynamic> userMap = jsonDecode(userData);
                          idCustomer = userMap['customer_id'];
                        }
                        final viewModelCart =
                            Provider.of<CartViewModel>(context, listen: false);
                        cartModel = CartModel(
                            idFood: foodDetail!.foodId,
                            customerId: idCustomer!,
                            name: foodDetail!.foodName,
                            price: foodDetail!.foodPrice,
                            imageUrl: foodDetail!.foodImg,
                            quantity: 1);

                        viewModelCart.addToCart(cartModel);
                      },
                      child: const Text(
                        "Thêm vào giỏ hàng",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          const TabBar(
                            labelColor: Colors.red,
                            unselectedLabelColor: Colors.black,
                            indicatorColor: Colors.red,
                            tabs: [
                              Tab(text: "Mô tả"),
                              Tab(text: "Nội dung"),
                            ],
                          ),
                          SizedBox(
                            height: 160,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TabBarView(
                                children: [
                                  // Tab đánh giá
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        // Nội dung đánh giá
                                        Text(
                                          textAlign: TextAlign.start,
                                          foodDetail!.foodContent,
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Tab review
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Text(
                                          foodDetail!.foodDesc,
                                          textAlign: TextAlign.justify,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Danh sách các sản phẩm cùng danh mục
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Cùng danh mục',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          FutureBuilder<List<FoodModel>?>(
                            future: futureFoodSame,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              } else {
                                List<FoodModel>? foodList = snapshot.data;
                                if (foodList != null) {
                                  return SizedBox(
                                    height: 250,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: foodList.length,
                                      itemBuilder: (context, index) {
                                        final food = foodList[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Card(
                                            elevation: 5.5,
                                            shadowColor: const Color.fromARGB(
                                                255, 204, 204, 204),
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 130,
                                                  width: 140,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          food.foodImg),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  food.foodName,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      PriceFormatter
                                                          .formatPriceFromString(
                                                              food.foodPrice),
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 30.0,
                                                    ),
                                                    Text(
                                                      '${food.totalOrders} bán',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            FoodDetailView(
                                                                foodId: food
                                                                    .foodId),
                                                      ),
                                                    );
                                                  },
                                                  style: ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                      Colors.blue,
                                                    ),
                                                    overlayColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                      Colors.blue.withOpacity(
                                                        0.1,
                                                      ),
                                                    ),
                                                  ),
                                                  child: const Text('Chọn mua'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return const Center(
                                    child: Text(
                                      'Không có sản phẩm cùng danh mục',
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text('Không có dữ liệu'),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
