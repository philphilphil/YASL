import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yasl/model/Category.dart';
import 'package:yasl/model/Listitem.dart';

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
    var ourDb = await openDatabase(path, version: 2, onCreate: _onCreate);
    return ourDb;
  }

  //items: int _id; String name; String desc; int amount; String _dateCreated; bool done = false; int category;

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        """CREATE TABLE items(id INTEGER PRIMARY KEY, name TEXT, desc TEXT, amount INTEGER, category INTEGER, dateCreated TEXT, done INTEGER not null); """);
    print("create table");
    await db.execute(
        """CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT, colorCode TEXT, rank INTEGER, isActive INTEGER);   """);
    await db.execute(
        "INSERT INTO categories VALUES (1, 'Fruits and Vegetables',  '0xFF40b74f', 1, 1);");
    await db.execute(
        "INSERT INTO categories VALUES (2, 'Refrigerated',  '0xFF63b6ff', 2, 1);");
    await db.execute(
        " INSERT INTO categories VALUES (3, 'Meat and Sausage',  '0xFFfc85c9', 3, 1);");
    await db.execute(
        "INSERT INTO categories VALUES (4, 'Snacks and Sweets',  '0xFFf23e3e', 4, 1);");
    await db.execute(
        "INSERT INTO categories VALUES (5, 'General Groceries',  '0xFFf9eb4a', 5, 1);");
    await db.execute(
        " INSERT INTO categories VALUES (6, 'Bakery',  '0xFF845f2f', 6, 1);");
    await db.execute(
        "INSERT INTO categories VALUES (7, 'Drinks',  '0xFF321c82', 7, 1);");
    await db.execute(
        " INSERT INTO categories VALUES (8, 'Frozen',  '0xFF3f0aff', 8, 1);");
    await db.execute(
        " INSERT INTO categories VALUES (9, 'Homewares',  '0xFF827e7b', 9, 1);");
    await db.execute(
        " INSERT INTO categories VALUES (10, 'Empty 2',  '0xFF262623', 10, 1);");
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

  Future<ListItem> getItem(int id) async {
    var dbClient = await db;

    var result = await dbClient.rawQuery("SELECT * FROM items WHERE id = $id");
    if (result.length == 0) return null;
    return new ListItem.fromMap(result.first);
  }

  Future<int> deleteItem(int id) async {
    var dbClient = await db;

    return await dbClient.delete("items", where: "id = ?", whereArgs: [id]);
  }

  Future<int> updateItem(ListItem item) async {
    var dbClient = await db;
    return await dbClient
        .update("items", item.toMap(), where: "id = ?", whereArgs: [item.id]);
  }

  //  CATEGORY HELPERS  /////////////////////////////
  Future<int> saveCategory(Category item) async {
    var dbClient = await db;
    int res = await dbClient.insert("categories", item.toMap());
    return res;
  }

  Future<List> getAllCategories() async {
    var dbClient = await db;
    var result =
        await dbClient.rawQuery("SELECT * FROM categories ORDER BY rank DESC");
    print("db");
    print(result);
    return result.toList();
  }

  Future<int> deleteCategory(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete("categories", where: "id = ?", whereArgs: [id]);
  }

  Future<int> updateCategory(Category item) async {
    var dbClient = await db;
    return await dbClient.update("categories", item.toMap(),
        where: "id = ?", whereArgs: [item.id]);
  }
}
