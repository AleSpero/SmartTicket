import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_ticket/models/product.dart';

class ShoppingItem {
  int _id;
  String _date;
  String _name;
  String _notes;
  Color _color;
  double _cost;
  int _ticketsNum;

  List<Product> products = new List<Product>();

  int get id => _id != null ? _id : -1;

  String get date => _date;

  int get ticketsNum => _ticketsNum;

  double get cost => products.length > 0 ?
    products
      .map((product) => product.cost)
      .reduce((current, next) => current + next) : 0;


  String get name => _name;

  ShoppingItem(){
    this._name = "Lista della Spesa"; //TODO lang
    this._cost = 0;
    this._ticketsNum = 0;
    this._color = Colors.blue;
    this._date = '${DateTime.now().millisecondsSinceEpoch}';
  }

  ShoppingItem.generate(String name) {
    this._date = '${DateTime.now().millisecondsSinceEpoch}';
    this._cost = 0;
    this._name = name;
    this._ticketsNum = 0;
  }

  Map<String, dynamic> toMap() {
    return {'date': _date,
      'name': _name,
      'ticketsNum': _ticketsNum,
      'color': _color.value,
      'notes': _notes
    };
  }

  ShoppingItem.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _date = map['date'];
    _name = map['name'];
    _ticketsNum = map['ticketsNum'];
    _color = Color(int.parse(map['color'])); //TODO test
    _notes = map['notes'];
  }

  void addProduct(Product product){
    product.shoppingItemId = id;
    products.add(product);
  }

  set name(String value) {
    _name = value;
  }

  set color(Color value) {
    _color = value;
  }

  set notes(String value) {
    _notes = value;
  }

  set id(int id){
    _id = id;
  }


}
