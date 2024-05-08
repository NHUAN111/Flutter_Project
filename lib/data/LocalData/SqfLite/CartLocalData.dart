import 'package:path/path.dart';
import 'package:project_specialized_1/model/cart_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

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
    final path = join(databasesPath, 'cart_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cart (
        id INTEGER PRIMARY KEY,
        customer_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        price TEXT NOT NULL,
        img_url TEXT NOT NULL,
        quantity INTEGER NOT NULL
      )
    ''');
  }

  Future<void> insertCart(CartModel cartModel) async {
    final db = await database;
    final existingProducts = await db.query(
      'cart',
      where: 'id = ?',
      whereArgs: [cartModel.idFood],
    );

    if (existingProducts.isNotEmpty) {
      final existingProduct = CartModel.fromJson(existingProducts.first);
      existingProduct
          .updateQuantity(existingProduct.quantity + cartModel.quantity);
      updateQty(cartModel.idFood, cartModel.customerId, cartModel.quantity);
      updateFood(existingProduct);
    } else {
      db.insert('cart', cartModel.toMap());
    }
  }

  Future<List<CartModel>> getAllFoods(int customerId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'cart',
      where: 'customer_id = ?',
      whereArgs: [customerId],
    );
    return List.generate(maps.length, (i) {
      final price = maps[i]['price'];
      return CartModel(
        idFood: maps[i]['id'] as int,
        customerId: maps[i]['customer_id'] as int,
        name: maps[i]['name'] as String,
        price: price != null
            ? price.toString()
            : '0', // Chuyển đổi giá trị sang chuỗi trước khi gán
        imageUrl: maps[i]['img_url'] as String,
        quantity: maps[i]['quantity'] as int,
      );
    });
  }

  Future<int> updateQty(int foodId, int customerId, int quantity) async {
    final db = await database;
    return await db.update(
      'cart',
      {'quantity': quantity}, // Dữ liệu mới cần cập nhật
      where:
          'id = ? AND customer_id = ?', // Điều kiện để xác định bản ghi cần cập nhật
      whereArgs: [foodId, customerId], // Tham số cho điều kiện where
    );
  }

  Future<int> updateFood(CartModel cartModel) async {
    final db = await database;
    return await db.update(
      'cart',
      cartModel.toMap(),
      where: 'id = ? AND customer_id = ?',
      whereArgs: [cartModel.idFood, cartModel.customerId],
    );
  }

  Future<int> deleteCart(int id, int customerId) async {
    final db = await database;
    return await db.delete(
      'cart',
      where: 'id = ? AND customer_id = ?',
      whereArgs: [id, customerId],
    );
  }

  Future<void> deleteAllData() async {
    final db = await database;
    await db.delete('cart');
  }
}
