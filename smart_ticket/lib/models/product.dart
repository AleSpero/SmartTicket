class Product{

  int _id;
  double _cost;
  String _name;
  int _shoppingItemId;

  //Costruttore
  Product(this._id, this._cost, this._name, this._shoppingItemId);

  String get name => _name;
  double get cost => _cost;
  int get id => _id;


  set shoppingItemId(int value) {
    _shoppingItemId = value;
  }

  Product.generate(String name){
    _name = name;
    _cost = 0;
  }

  //Metodi che servono per sqflite

  Product.fromMap(Map<String, dynamic> map){
    _id = map['id'];
    _cost = map['cost'];
    _name = map['name'];
    _shoppingItemId = map['shoppingItemId'];
  }

  Map<String, dynamic> toMap(){
    return {
      'id' : _id,
      'cost' : _cost,
      'name' : _name,
      'shoppingItemId' : _shoppingItemId
    };
  }


}