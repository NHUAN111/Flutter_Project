import 'package:flutter/material.dart';
import 'package:project_specialized_1/model/food_model.dart';
import 'package:project_specialized_1/views/Food/food_detail_view.dart';
import 'package:project_specialized_1/view_model/food_view_model.dart';
import 'package:project_specialized_1/widgets/format_price.dart';
import 'package:provider/provider.dart';

class FoodNewView extends StatefulWidget {
  const FoodNewView({Key? key}) : super(key: key);

  @override
  _FoodNewViewState createState() => _FoodNewViewState();
}

class _FoodNewViewState extends State<FoodNewView> {
  late Future<List<FoodModel>> futureFoods;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<FoodViewModel>(context, listen: false);
    futureFoods = viewModel.foodNew();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FoodModel>>(
      future: futureFoods,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text(''),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final List<FoodModel> foods = snapshot.data!;
          return SizedBox(
            height: 270,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: foods.length,
              itemBuilder: (context, index) {
                final food = foods[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    elevation: 2, // Độ nâng cao của thẻ
                    color: Colors.white,
                    child: Stack(
                      children: [
                        Container(
                          height: 130,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(food.foodImg),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            padding: const EdgeInsets.all(0.1),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle, // Hình dạng hình tròn
                              color: const Color.fromARGB(255, 240, 204, 201)
                                  .withOpacity(0.7), // Màu nền với độ mờ
                            ),
                            child: IconButton(
                              // color: const Color.fromARGB(255, 241, 56, 43),
                              onPressed: () {
                                print('${food.foodId}yeu thich');
                              },
                              icon: Image.asset(
                                'assets/images/heart.png',
                                width: 28,
                                height: 28,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  food.foodName,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      PriceFormatter.formatPriceFromString(
                                          food.foodPrice),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30.0,
                                    ),
                                    Text(
                                      '${food.totalOrders} bán', // Hiển thị tổng số lượng bán
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FoodDetailView(foodId: food.foodId),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                      const Color.fromARGB(255, 241, 56, 43),
                                    ),
                                    overlayColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color.fromARGB(
                                                    255, 233, 34, 47)
                                                .withOpacity(0.1)),
                                  ),
                                  child: const Text(
                                    'Chọn mua',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 241, 56, 43),
                                    ),
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
            ),
          );
        }
      },
    );
  }
}
