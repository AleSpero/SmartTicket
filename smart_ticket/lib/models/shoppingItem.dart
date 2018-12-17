class ShoppingItem{

  int _id;
  String _date;
  String _name;
  double _cost;
  int _ticketsNum;

  int get id => _id;
  String get date => _date;
  int get ticketsNum => _ticketsNum;
  double get cost => _cost;
  String get name => _name;

  ShoppingItem(this._id, this._date, this._name, this._ticketsNum);

  ShoppingItem.generate(String name){
    //TODO sistema, forse l'id non deve esserci ( o deve auto incementarsi)
    this._id = -1; //TODO rimuovi?
    this._date = '${DateTime.now().millisecondsSinceEpoch}';
    this._name = name;
    this._ticketsNum = 0;
  }

  Map<String, dynamic> toMap(){
    return {
      'id' : _id,
      'date' : _date,
      'name' : _name,
      'ticketsNum' : _ticketsNum
    };
  }

   static ShoppingItem fromMap(Map<String, dynamic> map){
    return new ShoppingItem(map['id'],
        map['date'],
        map['name'],
        map['ticketsNum']);
  }


}