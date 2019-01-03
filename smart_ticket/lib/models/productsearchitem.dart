class ProductSearchItem {

  int _id;
  String _name;
  //int category; //TODO


  //Costruttore
  ProductSearchItem(this._id, this._name);

//Getters
  String get name => _name;
  int get id => _id;

  //Metodi che servono per sqflite

  ProductSearchItem.fromMap(Map<String, dynamic> map){
    _id = map['id'];
    _name = map['name'];
  }

  Map<String, dynamic> toMap(){
    return {
      'id' : _id,
      'name' : _name,
    };
  }



}