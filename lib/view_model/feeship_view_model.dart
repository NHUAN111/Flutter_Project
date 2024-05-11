import 'package:flutter/foundation.dart';
import 'package:project_specialized_1/data/LocalData/SqfLite/FeeshipLocalData.dart';
import 'package:project_specialized_1/model/city_model.dart';
import 'package:project_specialized_1/model/feeship_model.dart';
import 'package:project_specialized_1/model/pronvice_model.dart';
import 'package:project_specialized_1/model/ward_mode.dart';
import 'package:project_specialized_1/repository/feeship_repository.dart';

class FeeshipViewModel with ChangeNotifier {
  final DatabaseHelperFeeship _databaseHelperFeeship = DatabaseHelperFeeship();
  final FeeshipRepository _feeshipRepository = FeeshipRepository();
  // City
  List<CityModel> _citylist = [];
  List<CityModel> get citys => _citylist;

  // province
  List<PronviceModel> _provincelist = [];
  List<PronviceModel> get provinces => _provincelist;

  // Ward
  List<WardModel> _wardlist = [];
  List<WardModel> get wards => _wardlist;

  // Feeship
  late FeeshipModel _feeshipModel;
  FeeshipModel get feeships => _feeshipModel;

  Future<List<CityModel>> fechCity() async {
    try {
      _citylist = await _feeshipRepository.fechCitys();
      notifyListeners();
      return _citylist;
    } catch (e) {
      print('Error fetching city $e');
      rethrow;
    }
  }

  Future<List<PronviceModel>> fechProvince(String province) async {
    try {
      _provincelist = await _feeshipRepository.fechPronvice(province);
      notifyListeners();
      return _provincelist;
    } catch (e) {
      print('Error fetching province $e');
      rethrow;
    }
  }

  Future<List<WardModel>> fechWard(String nameProvince) async {
    try {
      _wardlist = await _feeshipRepository.fechWard(nameProvince);
      notifyListeners();
      return _wardlist;
    } catch (e) {
      print('Error fetching ward $e');
      rethrow;
    }
  }

  Future<void> getFeeShip(
      String address, String customerName, String customerPhone) async {
    try {
      await _feeshipRepository.getFeeship(address, customerName, customerPhone);
    } catch (error) {
      if (kDebugMode) {
        print('Feeship fail $error');
      }
    }
    return;
  }

  Future<void> updateFeeship(FeeshipModel feeshipModel) async {
    try {
      await _databaseHelperFeeship.updateFeeship(feeshipModel);
    } catch (error) {
      if (kDebugMode) {
        print('Feeship fail update $error');
      }
    }
    return;
  }

  Future<List<FeeshipModel>> listAllDelivery(int customerId) async {
    try {
      return await _databaseHelperFeeship.getAllFeeship(customerId);
    } catch (e) {
      print('{$e}');
      throw Exception('Failed to list all delivery to table feeship: $e');
    }
  }

  Future<bool> checkFee(int customerId) async {
    try {
      return await _databaseHelperFeeship.checkFeeshipExist(customerId);
    } catch (e) {
      print('{$e}');
      throw Exception('Failed check fee: ');
    }
  }
}
