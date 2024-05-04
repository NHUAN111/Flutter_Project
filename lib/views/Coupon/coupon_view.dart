import 'package:flutter/material.dart';
import 'package:project_specialized_1/model/coupon_model.dart';
import 'package:project_specialized_1/view_model/coupon_view_model.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../data/LocalData/SharedPrefsManager/shared_preferences.dart';
import '../../view_model/category_view_model.dart';
import '../../widgets/format_price.dart';

class CouponView extends StatefulWidget {
  const CouponView({Key? key}) : super(key: key);

  @override
  _CouponViewState createState() => _CouponViewState();
}

class _CouponViewState extends State<CouponView> {
  late Future<List<CouponModel>> futureCoupon;
  bool isChecked = false; // Biến để theo dõi trạng thái của checkbox

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<CouponViewModel>(context, listen: false);
    futureCoupon = viewModel.fechCoupons();
  }

  // Hàm để quay lại trang ban đầu
  void resetPage() {
    setState(() {
      isChecked = false;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mã Giảm'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<CouponModel>>(
                future: futureCoupon,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    final List<CouponModel> couponItems = snapshot.data!;
                    return ListView.builder(
                      itemCount: couponItems.length,
                      itemBuilder: (context, index) {
                        final CouponModel item = couponItems[index];
                        return Padding(
                          padding: const EdgeInsets.all(1),
                          child: Card(
                            elevation: 3,
                            color: Colors.white,
                            child: ListTile(
                              leading: Container(
                                color: Colors.red,
                                height: 130,
                                width: 80,
                                alignment: Alignment.center,
                                child: Text(
                                  item.couponCondition == 1
                                      ? '${item.couponNumber} %'
                                      : PriceFormatter.formatPriceFromString(
                                          item.couponNumber.toString()),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.couponName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Mã: ${item.couponCode}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '${item.couponStart} đến ${item.couponEnd}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 105, 105, 105),
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Checkbox(
                                value: isChecked,
                                onChanged: (value) async {
                                  CouponModel couponModel = CouponModel(
                                    couponName: item.couponName,
                                    couponCode: item.couponCode,
                                    couponNumber: item.couponNumber,
                                    couponCondition: item.couponCondition,
                                    couponStart: item.couponStart,
                                    couponEnd: item.couponEnd,
                                  );
                                  print('Check coupon luu vao share');
                                  // Khởi tạo SharedPreferences
                                  await SharedPrefsManager.init();
                                  await SharedPrefsManager.setDataCoupon(
                                    Constant.COUPON_PREFERENCES,
                                    couponModel,
                                  );
                                  setState(() {
                                    isChecked = value!;
                                    resetPage(); // Gọi hàm để quay lại trang ban đầu
                                  });
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
