import 'package:flutter/foundation.dart';
import 'package:project_specialized_1/constant/constant.dart';
import 'package:project_specialized_1/data/LocalData/SharedPrefsManager/shared_preferences.dart';
import 'package:project_specialized_1/model/user_model.dart';

class UserViewModel with ChangeNotifier {
  Future<UserModel> getUser() async {
    final UserModel? userModel =
        SharedPrefsManager.getData(Constant.USER_PREFERENCES);

    return UserModel(customerName: userModel?.customerName.toString());
  }
}
