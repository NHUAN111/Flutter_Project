import 'package:flutter/material.dart';
import 'package:project_specialized_1/model/food_mode.dart';
import 'package:project_specialized_1/view/Food/food_detail_view.dart';
import 'package:project_specialized_1/view_model/food_view_model.dart';
import 'package:provider/provider.dart';

class FoodBestSellerView extends StatefulWidget {
  const FoodBestSellerView({Key? key}) : super(key: key);

  @override
  _FoodBestSellerViewState createState() => _FoodBestSellerViewState();
}

class _FoodBestSellerViewState extends State<FoodBestSellerView> {
  late Future<List<FoodModel>> futureFoods;
  late Future<FoodModel> futureFood;

  get viewModel => null;
  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<FoodViewModel>(context, listen: false);
    futureFoods = viewModel.foodBestSeller();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FoodModel>>(
      future: futureFoods,
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
          final List<FoodModel> foods = snapshot.data!;
          return SizedBox(
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: foods.length,
              itemBuilder: (context, index) {
                final food = foods[index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Card(
                      elevation: 2, // Độ nâng cao của thẻ
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 150,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(food.foodImg),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                food.foodName,
                                style: const TextStyle(fontSize: 15),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${food.foodPrice}', // Hiển thị giá trị
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    '${food.totalOrders} bán', // Hiển thị tổng số lượng bán
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FoodDetailView(
                                              foodId: food.foodId),
                                        ),
                                      );
                                    },
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color.fromARGB(
                                                  255, 233, 54, 54)),
                                      overlayColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color.fromARGB(
                                                      255, 243, 33, 44)
                                                  .withOpacity(0.1)),
                                    ),
                                    child: const Text('Chọn mua'),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      print('${food.foodId} yeu thich');
                                    },
                                    icon: const Icon(Icons.favorite_border),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
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
