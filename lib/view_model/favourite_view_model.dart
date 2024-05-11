import 'package:flutter/foundation.dart';
import 'package:project_specialized_1/data/LocalData/SqfLite/FavouriteLocalData.dart';
import 'package:project_specialized_1/model/favourite_model.dart';

class FavouriteViewModel with ChangeNotifier {
  final DatabaseHelperFavourite _databaseHelperFavourite =
      DatabaseHelperFavourite();

  Future<void> insertFavourite(FavouriteModel favouriteModel) async {
    try {
      await _databaseHelperFavourite.insertFavourite(favouriteModel);
    } catch (error) {
      if (kDebugMode) {
        print('Favourite fail $error');
      }
    }
  }

  Future<List<FavouriteModel>> listAllFavourite(int customerId) async {
    try {
      return await _databaseHelperFavourite.getAllFavourite(customerId);
    } catch (e) {
      print('{$e}');
      throw Exception('Failed to list all favourite to table favourite: $e');
    }
  }

  Future<bool> checkFavourite(int foodId, int customerId) async {
    try {
      return await _databaseHelperFavourite.checkFavouriteExist(
          foodId, customerId);
    } catch (e) {
      print('{$e}');
      throw Exception('Failed : ');
    }
  }

  Future<void> deleteFavourite(int foodId, int customerId) async {
    try {
      await _databaseHelperFavourite.deleteFavourite(foodId, customerId);
    } catch (e) {
      print('{$e}');
      throw Exception('Failed : ');
    }
  }
}
