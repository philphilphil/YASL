import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yasl/model/list_item.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
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

  //items: int _id; String name; String desc; int amount; String _dateCreated; bool done = false; int category;

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE items(id INTEGER PRIMARY KEY, name TEXT, desc TEXT, amount INTEGER, category INTEGER, dateCreated TEXT, done integer not null)");
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

//  ITEMS HELPERS  /////////////////////////////
  Future<int> saveItem(ListItem item) async {
    var dbClient = await db;
    int res = await dbClient.insert("items", item.toMap());
    return res;
  }

  Future<List> getAllItems() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM items ORDER BY done ASC, name COLLATE NOCASE ASC");

    return result.toList();
  }

  Future<int> deleteItem(int id) async {
    var dbClient = await db;

    return await dbClient.delete("items", where: "id = ?", whereArgs: [id]);
  }

  Future<int> updateItem(ListItem item) async {
    var dbClient = await db;
    return await dbClient.update("items", item.toMap(),
        where: "id = ?", whereArgs: [item.id]);
  }
}
