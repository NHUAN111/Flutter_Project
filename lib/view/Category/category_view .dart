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
          'Danh mục sản phẩm',
          style: TextStyle(
            fontSize: 18, // Kích thước chữ
            fontWeight: FontWeight.normal, // Độ đậm của chữ
            color: Colors.black, // Màu chữ
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder<List<CategoryModel>>(
          future: futureCategories,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.count(
                crossAxisCount: 3, // Số lượng danh mục mỗi hàng
                childAspectRatio: 1, // Tỉ lệ chiều rộng và chiều cao của mỗi ô
                children: snapshot.data!.map((category) {
                  return GestureDetector(
                    onTap: () {
                      // Xử lý khi nhấn vào danh mục
                    },
                    child: Card(
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
