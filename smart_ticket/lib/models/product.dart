import 'package:smart_ticket/models/baseproduct.dart';

class Product{

  static const BASE_CATEGORY_ICON = "other.png";

  //TODO valuta hierachy con baseproduct perchè così è na cacata

  int _id;
  double _cost;
  String _name;
  int _shoppingItemId;
  String _categoryIcon;


  //Costruttore
  Product(this._id, this._cost, this._name, this._shoppingItemId, this._categoryIcon);

  String get name => _name;
  String get categoryIcon => _categoryIcon;
  double get cost => _cost;
  int get id => _id;

  get shoppingItemId => _shoppingItemId;


  set shoppingItemId(int value) {
    _shoppingItemId = value;
  }

  Product.generate(String name){
    Product.generateWithCategory(name, BASE_CATEGORY_ICON);
  }

  Product.generateWithCategory(String name, String categoryIcon){
    _name = name;
    _cost = 0;
    _categoryIcon = categoryIcon;
  }

  //Metodi che servono per sqflite

  Product.fromMap(Map<String, dynamic> map){
    _id = map['id'];
    _cost = map['cost'].toDouble();
    _name = map['name'];
    _shoppingItemId = map['shopping_list_id'] == null ? -1 : map['shopping_list_id'];
    _categoryIcon = map['category_icon'];
  }

  Map<String, dynamic> toMap(){
    return {
      'id' : _id,
      'cost' : _cost,
      'name' : _name,
      'shopping_list_id' : _shoppingItemId,
      'category_icon' : _categoryIcon
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Product &&
              runtimeType == other.runtimeType &&
              _name == other._name;

  @override
  int get hashCode => _name.hashCode;

  set cost(double value) {
    _cost = value;
  }


}