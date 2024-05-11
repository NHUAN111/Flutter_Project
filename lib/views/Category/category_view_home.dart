import 'package:flutter/material.dart';
import 'package:project_specialized_1/model/category_mode.dart';
import 'package:project_specialized_1/view_model/category_view_model.dart';
import 'package:provider/provider.dart';

class CategoryHomeView extends StatefulWidget {
  const CategoryHomeView({Key? key}) : super(key: key);

  @override
  _CategoryHomeViewState createState() => _CategoryHomeViewState();
}

class _CategoryHomeViewState extends State<CategoryHomeView> {
  late Future<List<CategoryModel>> futureCategories;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<CategoryViewModel>(context, listen: false);
    futureCategories = viewModel.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel>>(
      future: futureCategories,
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
          final List<CategoryModel> category = snapshot.data!;
          return SizedBox(
            height: 125,
            // width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: category.length,
              itemBuilder: (context, index) {
                final item = category[index];
                return Container(
                  padding: const EdgeInsets.all(4.0),
                  width: 120,
                  height: 120,
                  child: Card(
                    color: Colors.white,
                    elevation: 4, // Độ nâng cao của thẻ
                    shadowColor: const Color.fromARGB(255, 255, 203, 199),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          item.categoryImg,
                          height: 50, // Độ cao của hình ảnh
                          width: 50, // Độ rộng của hình ảnh
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 18),
                        Text(
                          item.categoryName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
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
