class ProductSearchItem {

  int _id;
  String _name;
  String _categoryIcon; //TODO


  //Costruttore
  ProductSearchItem(this._id, this._name);

//Getters
  String get name => _name;
  String get categoryIcon => _categoryIcon;
  int get id => _id;

  //Metodi che servono per sqflite

  ProductSearchItem.fromMap(Map<String, dynamic> map){
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