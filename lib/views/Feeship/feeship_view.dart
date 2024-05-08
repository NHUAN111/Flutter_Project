import 'package:flutter/material.dart';
import 'package:project_specialized_1/model/city_model.dart';
import 'package:project_specialized_1/model/pronvice_model.dart';
import 'package:project_specialized_1/model/ward_mode.dart';
import 'package:project_specialized_1/view_model/feeship_view_model.dart';
import 'package:project_specialized_1/widgets/toast.dart';
import 'package:provider/provider.dart';

class FeeshipView extends StatefulWidget {
  const FeeshipView({Key? key}) : super(key: key);

  @override
  _FeeshipViewState createState() => _FeeshipViewState();
}

class _FeeshipViewState extends State<FeeshipView> {
  late Future<List<CityModel>> futureCity;
  List<PronviceModel> pronviceList = [];
  List<WardModel> wardList = [];
  String? selectedCity;
  String? selectedPronvice;
  String? selectedWard;
  TextEditingController addressController = TextEditingController();
  late double feeship = 0.0;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<FeeshipViewModel>(context, listen: false);
    futureCity = viewModel.fechCity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Địa Chỉ Nhận Hàng'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<CityModel>>(
          future: futureCity,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final cityList = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    hint: const Text('Tỉnh / Thành phố'),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    value: selectedCity,
                    onChanged: (String? newValue) async {
                      setState(() {
                        selectedCity = newValue;
                        selectedPronvice = null;
                        selectedWard = null;
                      });
                      // Load pronvice list for the selected city
                      pronviceList = await Provider.of<FeeshipViewModel>(
                              context,
                              listen: false)
                          .fechProvince(newValue!);

                      // Remove duplicate pronvice entries
                      setState(() {
                        pronviceList = pronviceList.toSet().toList();
                      });
                    },
                    items: cityList.map<DropdownMenuItem<String>>((city) {
                      return DropdownMenuItem<String>(
                        value: city.nameCity,
                        child: Text(city.nameCity),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    hint: const Text('Quận / Huyện'),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    value: selectedPronvice,
                    onChanged: (String? newValue) async {
                      setState(() {
                        selectedPronvice = newValue;
                        selectedWard = null;
                      });
                      // Load ward list for the selected pronvice
                      wardList = await Provider.of<FeeshipViewModel>(context,
                              listen: false)
                          .fechWard(newValue!);

                      // Remove duplicate ward entries
                      setState(() {
                        wardList = wardList.toSet().toList();
                      });
                    },
                    items:
                        pronviceList.map<DropdownMenuItem<String>>((pronvice) {
                      return DropdownMenuItem<String>(
                        value: pronvice.nameQuanhuyen,
                        child: Text(pronvice.nameQuanhuyen),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    hint: const Text('Xã / Phường'),
                    value: selectedWard,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedWard = newValue;
                      });
                    },
                    items: wardList.map<DropdownMenuItem<String>>((ward) {
                      return DropdownMenuItem<String>(
                        value: ward.nameXaphuong,
                        child: Text(ward.nameXaphuong),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      hintText: 'Số nhà, ngõ, đường...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              const Color.fromARGB(255, 241, 56, 43),
                          minimumSize: const Size(370, 46),
                          elevation: 3,
                        ),
                        onPressed: () async {
                          //Xu ly them phi van chuyen
                          String address =
                              "${addressController.text}, $selectedCity, $selectedPronvice, $selectedWard";
                          final viewModel = Provider.of<FeeshipViewModel>(
                              context,
                              listen: false);

                          viewModel.getFeeShip(address);
                          BaseToast.showSuccess(context, 'Thành công',
                              'Thêm thành công địa chỉ mới');
                        },
                        child: const Text('Xác nhận'),
                      ),
                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
