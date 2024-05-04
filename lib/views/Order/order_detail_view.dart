import 'package:flutter/material.dart';
import 'package:project_specialized_1/model/orders_detail_model.dart';
import 'package:project_specialized_1/view_model/orders_view_model.dart';
import 'package:provider/provider.dart';

import '../../widgets/format_price.dart';

class OrderDetailView extends StatefulWidget {
  final String orderCode;
  const OrderDetailView({Key? key, required this.orderCode}) : super(key: key);

  @override
  _OrderDetailViewState createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  late Future<List<OrdersDetailModel>> futureOrderDetail;
  double total = 0;
  String couponPrice = '';
  String feeShip = '';
  @override
  void initState() {
    super.initState();
    loadTotal();
  }

  void loadTotal() async {
    final viewModel = Provider.of<OrdersViewModel>(context, listen: false);
    futureOrderDetail = viewModel.fechOrderDetail(widget.orderCode);
    final orderDetail = await viewModel.fechOrderDetail(widget.orderCode);
    setState(() {
      total = calculateTotal(orderDetail);
    });
  }

  double calculateTotal(List<OrdersDetailModel> orderDetail) {
    total = 0;
    for (var orderDetail in orderDetail) {
      total += orderDetail.totalPrice;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chi tiết đơn ',
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<OrdersDetailModel>>(
        future: futureOrderDetail,
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
            final List<OrdersDetailModel> orderDetail = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Mã đơn - ${orderDetail.first.orderCode}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.timelapse),
                      Text(
                        ' Ngày đặt - ${orderDetail.first.order!.createdAt}',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.person),
                      Text(
                        ' Khách hàng - ${orderDetail.first.dataShipping!.shippingName} ',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.map),
                      Expanded(
                        child: Text(
                          ' Địa chỉ nhận - ${orderDetail.first.dataShipping!.shippingAddress}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: orderDetail.length,
                    itemBuilder: (context, index) {
                      final item = orderDetail[index];
                      feeShip = item.order!.orderFeeShip!;

                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          elevation: 2,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Container(
                                height: 130,
                                width: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(item.foodImg),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 150,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.foodName,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        PriceFormatter.formatPriceFromString(
                                            item.foodPrice.toString()),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 82,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Text(
                                        PriceFormatter.formatPriceFromString(
                                            item.totalPrice.toString()),
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Phí vận chuyển ',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            PriceFormatter.formatPriceFromString(feeShip),
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tổng thanh toán',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            PriceFormatter.formatPriceFromString(
                                total.toString()),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
