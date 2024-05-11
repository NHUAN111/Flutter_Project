import 'package:project_specialized_1/model/favourite_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperFavourite {
  static final DatabaseHelperFavourite _instance =
      DatabaseHelperFavourite._internal();

  factory DatabaseHelperFavourite() => _instance;

  DatabaseHelperFavourite._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'favourite_db.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    // Xóa bảng nếu tồn tại
    // await db.execute('DROP TABLE IF EXISTS favourite');
    await db.execute('''
      CREATE TABLE favourite (
        id INTEGER PRIMARY KEY,
        customerId INTEGER NOT NULL,
        foodId INTEGER NOT NULL,
        foodName TEXT NOT NULL,
        foodPrice TEXT NOT NULL,
        foodDesc TEXT NOT NULL,
        foodImg TEXT NOT NULL,
        totalOrders INTEGER NOT NULL
      )
    ''');
  }

  Future<void> insertFavourite(FavouriteModel favouriteModel) async {
    final db = await database;
    final existingProducts = await db.query(
      'favourite',
      where: 'foodId = ?',
      whereArgs: [favouriteModel.foodId],
    );
    if (existingProducts.isNotEmpty) {
      await db.delete(
        'favourite',
        where: 'foodId = ? AND customerId = ?',
        whereArgs: [favouriteModel.foodId, favouriteModel.customerId],
      );
    } else {
      db.insert('favourite', favouriteModel.toMap());
    }
  }

  Future<bool> checkFavouriteExist(int foodId, int customerId) async {
    final db = await database;
    final existingProducts = await db.query(
      'favourite',
      where: 'foodId = ? AND customerId = ?',
      whereArgs: [foodId, customerId],
    );
    return existingProducts
        .isNotEmpty; // Trả về true nếu có ít nhất một mục, ngược lại trả về false
  }

  Future<void> deleteFavourite(int foodId, int customerId) async {
    final db = await database;

    await db.delete(
      'favourite',
      where: 'foodId = ? AND customerId = ?',
      whereArgs: [foodId, customerId],
    );
  }

  Future<List<FavouriteModel>> getAllFavourite(int customerId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'favourite',
      where: 'customerId = ?',
      whereArgs: [customerId],
    );
    return List.generate(maps.length, (i) {
      return FavouriteModel(
        customerId: maps[i]['customerId'],
        foodId: maps[i]['foodId'],
        foodName: maps[i]['foodName'],
        foodPrice: maps[i]['foodPrice'],
        foodDesc: maps[i]['foodDesc'],
        foodImg: maps[i]['foodImg'],
        totalOrders: maps[i]['totalOrders'],
      );
    });
  }

  Future<void> deleteAllData() async {
    final db = await database;
    await db.delete('favourite');
  }
}
