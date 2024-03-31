import 'package:flutter/foundation.dart';
import 'package:project_specialized_1/constant/constant.dart';
import 'package:project_specialized_1/data/SharedPrefsManager/shared_preferences.dart';
import 'package:project_specialized_1/model/user_model.dart';

class UserViewModel with ChangeNotifier {
  Future<UserModel> getUser() async {
    final UserModel? userModel = SharedPrefsManager.getData<UserModel>(
      Constant.USER_PREFERENCES,
      (json) => UserModel.fromJson(json),
    );
    return UserModel(customerName: userModel?.customerName.toString());
  }
}
