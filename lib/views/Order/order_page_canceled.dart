import 'package:flutter/material.dart';
import 'package:project_specialized_1/model/orders_model.dart';
import 'package:project_specialized_1/view_model/orders_view_model.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../data/LocalData/SharedPrefsManager/shared_preferences.dart';
import '../../widgets/format_price.dart';
import 'order_detail_view.dart';

class OrdersCanceledPage extends StatefulWidget {
  const OrdersCanceledPage({Key? key}) : super(key: key);

  @override
  _OrdersCanceledPageState createState() => _OrdersCanceledPageState();
}

class _OrdersCanceledPageState extends State<OrdersCanceledPage> {
  late Future<List<OrdersModel>> futureOrders;

  @override
  void initState() {
    super.initState();
    final savedUser = SharedPrefsManager.getData(Constant.USER_PREFERENCES);
    print(savedUser!.customerId!);
    final viewModel = Provider.of<OrdersViewModel>(context, listen: false);
    futureOrders = viewModel.fechOrders(savedUser.customerId!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<OrdersModel>>(
      future: futureOrders,
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
          final List<OrdersModel> orders = snapshot.data!;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final OrdersModel item = orders[index];
              int qty = 0;
              int total = 0;
              int totalAll = 0;
              if (item.orderStatus == 2) {
                for (var orderDetail in item.orderDetail!) {
                  total = orderDetail.totalPrice;
                  qty = item.orderDetail!.length;
                  totalAll += total;
                }
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Mã đơn hàng: ${item.orderCode}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                item.createdAt!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          height: 20,
                          indent: 5,
                          endIndent: 5,
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 6),
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      item.orderDetail!.first.foodImg),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.orderDetail!.first.foodName,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  PriceFormatter.formatPriceFromString(item
                                      .orderDetail!.first.foodPrice
                                      .toString()),
                                ),
                                Text(
                                  'Số lượng: ${item.orderDetail!.first.foodSalesQuantity}',
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          height: 20,
                          indent: 5,
                          endIndent: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$qty sản phẩm + phí ship',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    'Hình thức thanh toán: ',
                                  ),
                                  const Text(
                                    'Trạng thái: chưa thanh toán',
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    PriceFormatter.formatPriceFromString(
                                      (int.parse(item.orderFeeShip!
                                                  .replaceAll(',', '')) +
                                              int.parse(totalAll.toString()))
                                          .toString(),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          height: 20,
                          indent: 5,
                          endIndent: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Thực hiện hành động khi nút được nhấn
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OrderDetailView(
                                          orderCode: item.orderCode!),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Xem chi tiết đơn hàng',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 223, 75, 75),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Thực hiện hành động khi nút được nhấn
                                },
                                icon: const Icon(Icons.navigate_next),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox
                  .shrink(); // Trả về widget rỗng để không hiển thị đơn hàng không phù hợp
            },
          );
        }
      },
    );
  }
}
