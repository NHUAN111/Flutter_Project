import 'package:flutter/material.dart';
import 'package:project_specialized_1/model/category_mode.dart';
import 'package:project_specialized_1/view_model/category_view_model.dart';
import 'package:provider/provider.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({Key? key}) : super(key: key);

  @override
  _FavouriteViewState createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  late Future<List<CategoryModel>> futureCategories;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<CategoryViewModel>(context, listen: false);
    futureCategories = viewModel.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yêu thích'),
        leading: const Icon(Icons.food_bank_rounded),
      ),
      body: Center(
        child: FutureBuilder<List<CategoryModel>>(
          future: futureCategories,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.count(
                crossAxisCount: 2, // Số lượng danh mục mỗi hàng
                childAspectRatio: 1, // Tỉ lệ chiều rộng và chiều cao của mỗi ô
                children: snapshot.data!.map((category) {
                  return GestureDetector(
                    onTap: () {
                      print(category.categoryId);
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 2, // Độ nâng cao của thẻ
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            category.categoryImg,
                            height: 70, // Độ cao của hình ảnh
                            width: 70, // Độ rộng của hình ảnh
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            category.categoryName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
