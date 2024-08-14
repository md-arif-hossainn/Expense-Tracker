import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/expense.dart';


class ExpenseDatabase {
  static final ExpenseDatabase instance = ExpenseDatabase._internal();

  static Database? _database;

  ExpenseDatabase._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'expense.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
        CREATE TABLE ${ExpenseFields.tableName} (
          ${ExpenseFields.id} ${ExpenseFields.idType},
          ${ExpenseFields.title} ${ExpenseFields.textType},
          ${ExpenseFields.amount} ${ExpenseFields.realType},
          ${ExpenseFields.category} ${ExpenseFields.textType},
          ${ExpenseFields.date} ${ExpenseFields.textType}
        )
      ''');

  }

  Future<ExpenseModel> create(ExpenseModel expense) async {
    final db = await instance.database;
    final id = await db.insert(ExpenseFields.tableName, expense.toJson());
    return expense.copy(id: id);
  }

  Future<ExpenseModel> read(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      ExpenseFields.tableName,
      columns: ExpenseFields.values,
      where: '${ExpenseFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ExpenseModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<ExpenseModel>> readAll() async {
    final db = await instance.database;
    const orderBy = '${ExpenseFields.date} DESC';
    final result = await db.query(ExpenseFields.tableName, orderBy: orderBy);
    return result.map((json) => ExpenseModel.fromJson(json)).toList();
  }

  Future<int> update(ExpenseModel note) async {
    final db = await instance.database;
    return db.update(
      ExpenseFields.tableName,
      note.toJson(),
      where: '${ExpenseFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      ExpenseFields.tableName,
      where: '${ExpenseFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
