import 'package:flutter/material.dart';
import 'package:project_specialized_1/model/food_mode.dart';
import 'package:project_specialized_1/view/Food/food_detail_view.dart';
import 'package:project_specialized_1/view_model/food_view_model.dart';
import 'package:provider/provider.dart';

class FoodAllView extends StatefulWidget {
  const FoodAllView({Key? key}) : super(key: key);

  @override
  _FoodAllViewState createState() => _FoodAllViewState();
}

class _FoodAllViewState extends State<FoodAllView> {
  late Future<List<FoodModel>> futureFoods;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<FoodViewModel>(context, listen: false);
    futureFoods = viewModel.foodDiscount();
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
            height: 300,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: foods.length,
              itemBuilder: (context, index) {
                final food = foods[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    elevation: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 160,
                          width: 190,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(food.foodImg),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          food.foodName,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '\$${food.foodPrice}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${food.totalOrders} bán',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
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
                                    FoodDetailView(foodId: food.foodId),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            overlayColor: MaterialStateProperty.all<Color>(
                              Colors.blue.withOpacity(0.1),
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
        }
      },
    );
  }
}
