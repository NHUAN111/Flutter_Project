import 'package:flutter/material.dart';
import 'package:project_specialized_1/constant/constant.dart';
import 'package:project_specialized_1/data/LocalData/SharedPrefsManager/shared_preferences.dart';
import 'package:project_specialized_1/model/feeship_model.dart';
import 'package:project_specialized_1/utils/routes/routes_name.dart';
import 'package:project_specialized_1/view_model/feeship_view_model.dart';
import 'package:provider/provider.dart';

class DeliveryView extends StatefulWidget {
  const DeliveryView({Key? key}) : super(key: key);

  @override
  _DeliveryViewState createState() => _DeliveryViewState();
}

class _DeliveryViewState extends State<DeliveryView> {
  late Future<List<FeeshipModel>> futureFeeship;
  late List<FeeshipModel> feeShipItems = [];
  List<FeeshipModel> feeShip = [];
  bool isChecked = false;
  int? checkedIndex;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final viewModel = Provider.of<FeeshipViewModel>(context, listen: false);
    final user = SharedPrefsManager.getData(Constant.USER_PREFERENCES);
    futureFeeship = viewModel.listAllDelivery(user!.customerId!);
    final deliveryItemsData = await viewModel.listAllDelivery(user.customerId!);
    setState(() {
      feeShipItems = deliveryItemsData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Địa Chỉ Của Bạn'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.feeship);
            },
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<FeeshipModel>>(
                future: futureFeeship,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Đã xảy ra lỗi: ${snapshot.error}');
                  } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                    return Center(
                      child: SizedBox(
                        width: 200, // Độ rộng mong muốn của nút
                        child: ElevatedButton(
                          onPressed: () {
                            // Xu ly
                            Navigator.pushNamed(context, RoutesName.feeship);
                          },
                          child: const Text(
                            'Thêm địa chỉ mới',
                          ),
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: feeShipItems.length,
                      itemBuilder: (context, index) {
                        final FeeshipModel item = feeShipItems[index];

                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 6),
                          child: Column(
                            children: [
                              Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10, top: 8, bottom: 8),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Người Nhận: ${item.customerName}',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Điện Thoại: ${item.customerPhone}',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 310,
                                            child: Text(
                                              item.address.toString(),
                                              maxLines: 2,
                                              style: const TextStyle(),
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              // Xu ly xoa
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Color.fromARGB(
                                                  255, 232, 60, 60),
                                            ),
                                          ),
                                          Checkbox(
                                            value: checkedIndex == index
                                                ? isChecked
                                                : false,
                                            onChanged: (value) async {
                                              final user =
                                                  SharedPrefsManager.getData(
                                                      Constant
                                                          .USER_PREFERENCES);
                                              if (feeShip.isEmpty) {
                                                FeeshipModel feeshipModel =
                                                    FeeshipModel(
                                                  customerId: user!.customerId,
                                                  feeship: item.feeship,
                                                  address: item.address,
                                                  statusFee: 1,
                                                  customerName:
                                                      item.customerName,
                                                  customerPhone:
                                                      item.customerPhone,
                                                );

                                                await SharedPrefsManager.init();
                                                await SharedPrefsManager
                                                    .setDataFeeship(
                                                  Constant.FEESHIP_PREFERENCES,
                                                  feeshipModel,
                                                );
                                                print(
                                                    feeshipModel.customerName);
                                              }
                                              setState(() {
                                                isChecked = value!;
                                                checkedIndex = index;
                                              });
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
