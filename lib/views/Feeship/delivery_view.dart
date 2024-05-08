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

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    final viewModel = Provider.of<FeeshipViewModel>(context, listen: false);
    final user = SharedPrefsManager.getData(Constant.USER_PREFERENCES);
    futureFeeship = viewModel.listAllDelivery(user!.customerId!);
    final deliveryItemsData = await viewModel.listAllDelivery(user.customerId!);
    setState(() {
      feeShipItems = deliveryItemsData;
    });
    print(deliveryItemsData.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Địa Chỉ Của Bạn'),
        centerTitle: true,
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
                    return const Text(
                      'Thêm địa chỉ của bạn',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: feeShipItems.length,
                      itemBuilder: (context, index) {
                        final FeeshipModel item = feeShipItems[index];

                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Card(
                                elevation: 2,
                                child: Row(
                                  children: [
                                    Text(
                                      item.address.toString(),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Xu ly
                                  Navigator.pushNamed(
                                      context, RoutesName.feeship);
                                },
                                child: const Text(
                                  'Thêm địa chỉ mới',
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
