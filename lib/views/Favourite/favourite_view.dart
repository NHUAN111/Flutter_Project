import 'package:flutter/material.dart';
import 'package:project_specialized_1/constant/constant.dart';
import 'package:project_specialized_1/data/LocalData/SharedPrefsManager/shared_preferences.dart';
import 'package:project_specialized_1/model/favourite_model.dart';
import 'package:project_specialized_1/view_model/favourite_view_model.dart';
import 'package:project_specialized_1/views/Food/food_detail_view.dart';
import 'package:project_specialized_1/widgets/format_price.dart';
import 'package:project_specialized_1/widgets/toast.dart';
import 'package:provider/provider.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({Key? key}) : super(key: key);

  @override
  _FavouriteViewState createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  late Future<List<FavouriteModel>> futureFavourite;
  // late List<FavouriteModel> listAllFavourite = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    setState(() {
      final user = SharedPrefsManager.getData(Constant.USER_PREFERENCES);
      final viewModel = Provider.of<FavouriteViewModel>(context, listen: false);
      futureFavourite = viewModel.listAllFavourite(user!.customerId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Sản Phẩm Yêu Thích',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<FavouriteModel>>(
          future: futureFavourite,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/empty-cart.png',
                      width: 180,
                      height: 220,
                    ),
                    const Text(
                      'Khám phá ngay đi nào !!!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7, // Độ cao của thẻ
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  children: snapshot.data!.map((favourite) {
                    return GestureDetector(
                      onTap: () {
                        // Xử lý khi nhấn vào danh mục
                      },
                      child: Card(
                        elevation: 2, // Độ nâng cao của thẻ
                        color: Colors.white,
                        child: Stack(
                          children: [
                            Container(
                              height: 150,
                              width: 190,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(favourite.foodImg!),
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
                                  color: const Color.fromARGB(
                                          255, 240, 204, 201)
                                      .withOpacity(0.7), // Màu nền với độ mờ
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    // Xu ly xoa khoi yeu thich
                                    final savedUser =
                                        SharedPrefsManager.getData(
                                            Constant.USER_PREFERENCES);
                                    final viewModelFavourite =
                                        Provider.of<FavouriteViewModel>(context,
                                            listen: false);
                                    viewModelFavourite.deleteFavourite(
                                        favourite.foodId!,
                                        savedUser!.customerId!);
                                    BaseToast.showSuccess(context, 'Thành công',
                                        'Đã xóa khỏi mục yêu thích');
                                    loadData();
                                  },
                                  icon: Image.asset(
                                    'assets/images/heart.png',
                                    width: 28,
                                    height: 28,
                                    color: Colors.red,
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
                                      favourite.foodName!,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          PriceFormatter.formatPriceFromString(
                                              favourite.foodPrice!),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 30.0,
                                        ),
                                        Text(
                                          '${favourite.totalOrders} bán', // Hiển thị tổng số lượng bán
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
                                                FoodDetailView(
                                                    foodId: favourite.foodId!),
                                          ),
                                        );
                                      },
                                      style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                          const Color.fromARGB(
                                              255, 241, 56, 43),
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
                                          color:
                                              Color.fromARGB(255, 241, 56, 43),
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
                  }).toList(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
