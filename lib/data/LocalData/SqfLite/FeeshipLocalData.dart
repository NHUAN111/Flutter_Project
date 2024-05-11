import 'package:project_specialized_1/model/feeship_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperFeeship {
  static final DatabaseHelperFeeship _instance =
      DatabaseHelperFeeship._internal();

  factory DatabaseHelperFeeship() => _instance;

  DatabaseHelperFeeship._internal();

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
    final path = join(databasesPath, 'new_feeship_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE feeShip (
        id INTEGER PRIMARY KEY,
        customerId INTEGER,
        feeship INTEGER,
        address TEXT,
        statusFee INTEGER,
        customerName TEXT,
        customerPhone TEXT
      )
    ''');
  }

  Future<void> insertFeeShip(FeeshipModel feeshipModel) async {
    final db = await database;
    await db.insert('feeShip', feeshipModel.toMap());
  }

  Future<List<FeeshipModel>> getAllFeeship(int customerId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'feeShip',
      where: 'customerId = ?',
      whereArgs: [customerId],
    );
    return List.generate(maps.length, (i) {
      return FeeshipModel(
        customerId: maps[i]['customerId'],
        feeship: maps[i]['feeship'],
        address: maps[i]['address'],
        statusFee: maps[i]['statusFee'],
        customerName: maps[i]['customerName'],
        customerPhone: maps[i]['customerPhone'],
      );
    });
  }

  Future<int> deleteFeeship(String address, int customerId) async {
    final db = await database;
    return await db.delete(
      'feeShip',
      where: 'address = ? AND customerId = ?',
      whereArgs: [address, customerId],
    );
  }

  Future<void> deleteAllData() async {
    final db = await database;
    await db.delete('feeShip');
  }

  // Update lai
  Future<void> updateFeeship(FeeshipModel feeshipModel) async {
    final db = await database;
    // Kiểm tra nếu trạng thái hiện tại là 1, thì cập nhật lại thành 0, và ngược lại
    int newStatus = feeshipModel.statusFee == 1 ? 0 : 1;

    await db.update(
      'feeShip',
      {
        'statusFee': newStatus
      }, // Dữ liệu được cập nhật (chỉ cập nhật trường statusFee)
      where: 'customerId = ? AND statusFee = ?', // Điều kiện WHERE
      whereArgs: [
        feeshipModel.customerId,
        feeshipModel.statusFee
      ], // Tham số điều kiện WHERE
    );
  }

  Future<bool> checkFeeshipExist(int customerId) async {
    final db = await database;
    final existingFee = await db.query(
      'feeShip',
      where: 'customerId = ? AND statusFee = ?',
      whereArgs: [customerId, 1],
    );
    return existingFee
        .isNotEmpty; // Trả về true nếu có ít nhất một mục, ngược lại trả về false
  }

  Future<FeeshipModel?> getDelivery(int customerId, int status) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT * FROM feeShip WHERE customerId = ? AND statusFee = ?',
      [
        customerId,
        status,
      ],
    );
    if (result.isNotEmpty) {
      return FeeshipModel.fromJson(result.first);
    } else {
      return null;
    }
  }

  Future<void> deleteTable() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'feeship_database.db');
    await deleteDatabase(path);
  }
}
