import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yasl/model/list_item.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableItems = "listItemTable";
  final String columnId = "id";
  final String columnName = "name";
  final String columnDateCreated = "dateCreated";
  final String columnDone = "done";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "maindb.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tableItems($columnId INTEGER PRIMARY KEY, $columnName TEXT, $columnDateCreated TEXT, $columnDone integer not null)");
  }

  Future<int> saveItem(ListItem item) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableItems", item.toMap());
    return res;
  }

  Future<List> getAllItems() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableItems");

    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tableItems"));
  }

  Future<ListItem> getItem(int id) async {
    var dbClient = await db;

    var result = await dbClient
        .rawQuery("SELECT * FROM $tableItems WHERE $columnId = $id");
    if (result.length == 0) return null;
    return new ListItem.fromMap(result.first);
  }

  Future<int> deleteItem(int id) async {
    var dbClient = await db;

    return await dbClient
        .delete(tableItems, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> updateItem(ListItem item) async {
    var dbClient = await db;
    return await dbClient.update(tableItems, item.toMap(),
        where: "$columnId = ?", whereArgs: [item.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
