
import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_ticket/models/product.dart';
import 'package:smart_ticket/models/shoppingItem.dart';
import 'package:sqflite/sqflite.dart';

class StDbHelper {

  static const String TABLE_PRODUCT = "product";
  static const String TABLE_SHOPPING_ITEM = "shopping_item";
  static const String _DB_CREATION_STATEMENT = "CREATE TABLE IF NOT EXISTS 'shopping_item' ("
      "'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"
      "'name'	TEXT NOT NULL,"
      "'date'	TEXT NOT NULL,"
      "'ticketsNum'	INTEGER"
      ");"
      "CREATE TABLE IF NOT EXISTS 'product' ("
      "'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"
      "'cost'	INTEGER NOT NULL,"
      "'name'	TEXT,"
      "'shopping_list_id'	INTEGER NOT NULL,"
      "FOREIGN KEY('shopping_list_id') REFERENCES 'shopping_item'('id')"
      ");";

  static final StDbHelper _instance = new StDbHelper.internal();
  factory StDbHelper() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  StDbHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //TODO assets?
    String path = join(documentsDirectory.path, "SmartTicketDb.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
       _DB_CREATION_STATEMENT);
  }


  //Metodi da utilizzare (prendili da quelli fatti con room)

  void addProduct(Product product) async {
    var dbClient = await db;
    await dbClient.insert(TABLE_PRODUCT, product.toMap());
  }

  void removeProduct(Product product){
    //TODO implement me
  }

  void addShoppingItem(ShoppingItem item) async {
    //TODO
    var dbClient = await db;
    await dbClient.insert(TABLE_SHOPPING_ITEM, item.toMap());
  }

  void removeShoppingItem(ShoppingItem item){
    //TODO implement me
  }

  Future<List<ShoppingItem>> getAllItems() async {
    var dbClient = await db;
    var tempResult = await dbClient.query(TABLE_SHOPPING_ITEM);
    var result = List<ShoppingItem>();

    for(Map map in tempResult){
      result.add(ShoppingItem.fromMap(map));
    }

    return result;
  }

  /*Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  Future<List<User>> getUser() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM User');
    List<User> employees = new List();
    for (int i = 0; i < list.length; i++) {
      var user =
          new User(list[i]["firstname"], list[i]["lastname"], list[i]["dob"]);
      user.setUserId(list[i]["id"]);
      employees.add(user);
    }
    print(employees.length);
    return employees;
  }

  Future<int> deleteUsers(User user) async {
    var dbClient = await db;

    int res =
        await dbClient.rawDelete('DELETE FROM User WHERE id = ?', [user.id]);
    return res;
  }

  Future<bool> update(User user) async {
    var dbClient = await db;
    int res =   await dbClient.update("User", user.toMap(),
        where: "id = ?", whereArgs: <int>[user.id]);
    return res > 0 ? true : false;
  }*/
}