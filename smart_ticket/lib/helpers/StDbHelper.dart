
import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_ticket/models/product.dart';
import 'package:smart_ticket/models/shoppingItem.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class StDbHelper {

  static const String TABLE_PRODUCT = "product";
  static const String TABLE_SHOPPING_ITEM = "shopping_item";
  static const String _SHOPPINGITEM_CREATION_STATEMENT = "CREATE TABLE IF NOT EXISTS 'shopping_item' ("
      "'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"
      "'name'	TEXT NOT NULL,"
      "'date'	TEXT NOT NULL,"
      "'notes' TEXT,"
      "'color' TEXT NOT NULL,"
      "'ticketsNum'	INTEGER"
      ");";
  static const String _PRODUCT_CREATION_STATEMENT = "CREATE TABLE IF NOT EXISTS 'product' ("
      "'id'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"
      "'cost'	INTEGER NOT NULL,"
      "'name'	TEXT,"
      "'shopping_list_id'	INTEGER NOT NULL,"
      "FOREIGN KEY('shopping_list_id') REFERENCES 'shopping_item'('id')"
      ");";

  static const String _GET_PRODUCTS_FROM_ID = "SELECT * from product where id = ?";

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
    await db.execute(_SHOPPINGITEM_CREATION_STATEMENT);
    await db.execute(_PRODUCT_CREATION_STATEMENT);
  }


  //Metodi da utilizzare (prendili da quelli fatti con room)

  void addProduct(Product product) async {
    var dbClient = await db;
    await dbClient.insert(TABLE_PRODUCT, product.toMap());
  }

  Future<int> removeProduct(Product product) async {
    //TODO implement me
    var dbClient = await db;
    return await dbClient.delete(TABLE_PRODUCT, where: "id = ?", whereArgs: [product.id]);
  }

  void addShoppingItem(ShoppingItem item) async {
    var dbClient = await db;
    await dbClient.insert(TABLE_SHOPPING_ITEM, item.toMap());
  }

  Future<int> removeShoppingItem(ShoppingItem item) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE_SHOPPING_ITEM, where: "id = ?", whereArgs: [item.id]);  }

  Future<List<ShoppingItem>> getAllItems() async {
    var dbClient = await db;
    var tempResult = await dbClient.query(TABLE_SHOPPING_ITEM);
    var result = List<ShoppingItem>();

    for(Map map in tempResult){
      result.add(ShoppingItem.fromMap(map));
    }

    return result;
  }

  Future<List<Product>> getProductsById(int shoppingItemId) async {
    try {
      var dbClient = await db;

      var tempResult = await dbClient.query(
          TABLE_PRODUCT, where: "shopping_list_id = ?",
          whereArgs: [shoppingItemId]);

      var result = List<Product>();

      for (Map map in tempResult) {
        result.add(Product.fromMap(map));
      }

      //debugPrint("Found ${result.length} products");

      return result;
    } on Exception catch(e){
      debugPrint(e.toString());
    }

  }
}