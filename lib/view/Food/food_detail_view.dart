import 'package:flutter/material.dart';
import 'package:project_specialized_1/constant/constant.dart';
import 'package:project_specialized_1/data/SharedPrefsManager/shared_preferences.dart';
import 'package:project_specialized_1/model/food_mode.dart';
import 'package:project_specialized_1/view_model/food_view_model.dart';
import 'package:provider/provider.dart';

class FoodDetailView extends StatefulWidget {
  const FoodDetailView({super.key, required this.foodId});
  final int foodId;
  @override
  _FoodDetailViewState createState() => _FoodDetailViewState();
}

class _FoodDetailViewState extends State<FoodDetailView> {
  late Future<FoodModel?> futureFood;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<FoodViewModel>(context, listen: false);
    futureFood = viewModel.foodDetail(widget.foodId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết món'),
      ),
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
              FoodModel? foodDetail = snapshot.data;
              if (foodDetail != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Phần ảnh và thông tin cơ bản của món
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Ảnh món
                          Image.network(
                            foodDetail.foodImg, // Sử dụng URL ảnh từ foodDetail
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 16),
                          // Giá và số lượng đã bán
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Giá: ${foodDetail.foodPrice}', // Sử dụng giá từ foodDetail
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Đã bán: ${foodDetail.totalOrders}', // Sử dụng số lượng đã bán từ foodDetail
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Mô tả sản phẩm
                          const Text(
                            'Mô tả sản phẩm:', // Tiêu đề mô tả
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            foodDetail.foodDesc, // Sử dụng mô tả từ foodDetail
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    // Danh sách các sản phẩm cùng danh mục
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      color: Colors.grey[200],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Cùng danh mục sản phẩm', // Tiêu đề danh sách
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          // ListView hiển thị danh sách các sản phẩm
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 5, // Số lượng sản phẩm để hiển thị
                            itemBuilder: (context, index) {
                              // Tạo một item cho ListView
                              return ListTile(
                                leading: const CircleAvatar(
                                  // Ảnh đại diện của sản phẩm
                                  backgroundImage: AssetImage(
                                      'assets/product_image.png'), // Thay thế bằng đường dẫn thực tế
                                ),
                                title:
                                    Text('Tên sản phẩm $index'), // Tên sản phẩm
                                subtitle:
                                    const Text('Giá: \$10'), // Giá sản phẩm
                                onTap: () {
                                  // Xử lý khi người dùng nhấn vào sản phẩm
                                  print('Đã chọn sản phẩm $index');
                                },
                              );
                            },
                          ),
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
