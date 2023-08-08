import 'dart:io';

import 'package:database/Screen/Home/modal/expense_modal.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// ignore: camel_case_types
class DB_helper {
  // ignore: non_constant_identifier_names
  static DB_helper db_helper = DB_helper();
  Database? database;

  final String dbPath = "dbase.db";
  final String dbName = "datatable";

  Future<Database?> createDB() async {
    if (database != null) {
      return database;
    } else {
      return await initDB();
    }
  }

  Future<Database> initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, dbPath);
    String query =
        'CREATE TABLE $dbName (id INTEGER PRIMARY KEY AUTOINCREMENT, category TEXT, amount INTEGER, date TEXT, status TEXT, time TEXT, note TEXT)';
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        return await db.execute(query);
      },
    );
  }

  Future<void> insertInDB(ExpenseModel expenseModel) async {
    database = await createDB();
    await database!.insert(dbName, {
      'category': expenseModel.category,
      'amount': expenseModel.amount,
      'date': expenseModel.date,
      'status': expenseModel.status,
      'time': expenseModel.time,
      'note': expenseModel.note,

    });
  }

  Future<List<Map>> readDB() async {
    database = await createDB();
    String query = 'SELECT * FROM $dbName';
    List<Map> list = await database!.rawQuery(query);
    return list;
  }

  Future<List<Map>> filterReadDB(String status) async {
    database = await createDB();
    String query = 'SELECT * FROM $dbName WHERE status = "$status"';
    List<Map> list = await database!.rawQuery(query);
    return list;
  }

  Future getTotal(String status) async {
    database = await createDB();
    String query = 'SELECT SUM(amount) FROM $dbName WHERE status = "$status"';
    var result = await database!.rawQuery(query);
    var value = result[0]["SUM(amount)"];
    print(value);
    return value;

  }
   // ignore: non_constant_identifier_names

  // ignore: non_constant_identifier_names
  Future<List<Map>> filter_cate({String? cate})
  async {
      database = await createDB();
      String query = "";
      query = "SELECT * FROM $dbName WHERE category = '$cate'";
      List<Map> l1 = await database!.rawQuery(query);
      return l1;
  }

  Future<void> deleteDB(int id) async {
    database = await createDB();
    database!.delete(dbName, where: "id=?", whereArgs: [id]);
  }

  Future<void> updateDB(ExpenseModel expenseModel) async {
    database = await createDB();
    database!.update(
        dbName,
        {
          'category': expenseModel.category,
          'amount': expenseModel.amount,
          'note': expenseModel.note,
          'date': expenseModel.date,
          'status': expenseModel.status,
        },
        where: "id=?",
        whereArgs: [expenseModel.id]);
  }

}
