import 'package:flutter/material.dart';
import 'package:project_specialized_1/constant/constant.dart';
import 'package:project_specialized_1/data/LocalData/SharedPrefsManager/shared_preferences.dart';
import 'package:project_specialized_1/model/cart_model.dart';
import 'package:project_specialized_1/utils/routes/routes_name.dart';
import 'package:project_specialized_1/view_model/cart_view_model.dart';
import 'package:project_specialized_1/widgets/format_price.dart';
import 'package:provider/provider.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  _CheckoutViewState createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  late Future<List<CartModel>> futureCart;
  List<String> list = <String>['Thanh Toán Tiền Mặt', 'Thanh Toán Bằng Thẻ'];
  String? dropdownValue;
  bool checkFee = false;
  String customerName = '';
  String customerPhone = '';
  String customerAddress = '';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context)?.isCurrent ?? false) {
      loadData();
    }
  }

  void loadData() async {
    final user = SharedPrefsManager.getData(Constant.USER_PREFERENCES);
    final viewModel = Provider.of<CartViewModel>(context, listen: false);
    futureCart = viewModel.listAllCart(user!.customerId!);
    final feeship =
        SharedPrefsManager.getDataFeeship(Constant.FEESHIP_PREFERENCES);

    if (feeship != null) {
      setState(() {
        checkFee = true;
        customerName = feeship.customerName!;
        customerPhone = feeship.customerPhone!;
        customerAddress = feeship.address!;
      });
    } else {
      setState(() {
        checkFee = false;
        customerName = '';
        customerPhone = '';
        customerAddress = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi Tiết Thanh Toán'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          loadData();
        },
        child: Center(
          child: Column(
            children: [
              Container(
                color: const Color.fromARGB(255, 255, 239, 230),
                child: const Padding(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Color.fromARGB(255, 255, 127, 67),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'Trước khi đặt hàng, hãy đảm bảo địa chỉ chính xác và phù hợp với địa chỉ hiện tại của bạn.',
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 14),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add_location_alt_rounded,
                          color: Color.fromARGB(255, 255, 102, 91),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    checkFee ? customerName : 'Người Nhận',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 70),
                                  Text(
                                    checkFee
                                        ? customerPhone
                                        : '(Chưa xác định)',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 96, 96, 96),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                checkFee
                                    ? customerAddress
                                    : 'Địa chỉ người nhận (vui lòng chọn thông tin)',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Xu ly
                            SharedPrefsManager.init();
                            SharedPrefsManager.removeData(
                                Constant.FEESHIP_PREFERENCES);
                            Navigator.pushNamed(
                                context, RoutesName.addressDelivery);
                          },
                          icon: const Icon(
                            Icons.navigate_next_rounded,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              FutureBuilder<List<CartModel>>(
                future: futureCart,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    final List<CartModel> cartItems = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          '    Sản Phẩm Đã Chọn',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 370,
                          child: ListView.builder(
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              final item = cartItems[index];
                              return Container(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 10, left: 20, right: 20),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    // color: const Color.fromARGB(
                                    //     255, 241, 241, 241),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            8), // Rounded corners
                                        child: Image.network(
                                          item.imageUrl,
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            PriceFormatter
                                                .formatPriceFromString(item
                                                    .price), // Assuming PriceFormatter is a helper class
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 89, 77),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${item.quantity}x',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: DropdownMenu<String>(
                            width: 390,
                            initialSelection: list.first,
                            onSelected: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                                print(dropdownValue);
                              });
                            },
                            dropdownMenuEntries: list
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(
                                  value: value, label: value);
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 10),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tổng thanh toán',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '100.000 đ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 249, 75, 63),
                                  textStyle: const TextStyle(
                                    fontSize: 22,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  // Qua thanh toan gui len server
                                },
                                child: const Text(
                                  'Thanh Toán',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
