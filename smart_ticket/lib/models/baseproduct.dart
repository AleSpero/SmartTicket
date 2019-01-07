import 'package:smart_ticket/models/product.dart';

class BaseProduct {

  int _id;
  String _name;
  String _categoryIcon;


  //Costruttore
  BaseProduct(this._id, this._name);


  BaseProduct.generate(String name){
    _name = name;
    _categoryIcon = Product.BASE_CATEGORY_ICON;
  }

//Getters
  String get name => _name;
  String get categoryIcon => _categoryIcon;
  int get id => _id;

  //Metodi che servono per sqflite

  BaseProduct.fromMap(Map<String, dynamic> map){
    _id = map['id'];
    _name = map['name'];
    _categoryIcon = map['img_path'];
  }

  Map<String, dynamic> toMap(){
    return {
      'id' : _id,
      'name' : _name,
      'img_path' : _categoryIcon
    };
  }



}