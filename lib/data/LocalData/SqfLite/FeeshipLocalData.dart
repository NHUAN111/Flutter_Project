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
    final path = join(databasesPath, 'feeship_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE feeShip (
        customerId INTEGER PRIMARY KEY,
        feeship INTEGER NOT NULL,
        address TEXT NOT NULL,
        statusFee INTEGER NOT NULL
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
}
