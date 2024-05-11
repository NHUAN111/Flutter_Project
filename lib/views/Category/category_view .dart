import 'package:flutter/material.dart';
import 'package:project_specialized_1/model/category_mode.dart';
import 'package:project_specialized_1/view_model/category_view_model.dart';
import 'package:provider/provider.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
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
        title: const Text(
          'Danh Mục',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Center(
          child: FutureBuilder<List<CategoryModel>>(
            future: futureCategories,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.count(
                    crossAxisCount: 2, // Số lượng danh mục mỗi hàng
                    childAspectRatio:
                        1, // Tỉ lệ chiều rộng và chiều cao của mỗi ô
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: snapshot.data!.map((category) {
                      return GestureDetector(
                        onTap: () {
                          // Xử lý khi nhấn vào danh mục
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
                                height: 80, // Độ cao của hình ảnh
                                width: 80, // Độ rộng của hình ảnh
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 18),
                              Text(
                                category.categoryName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
