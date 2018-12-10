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


  ShoppingItem(this._id, this._date, this._name, this._cost, this._ticketsNum);

  Map<String, dynamic> toMap(){
    return {
      'id' : _id,
      'date' : _date,
      'name' : _name,
      'cost' : _cost,
      'ticketsNum' : _ticketsNum
    };
  }

   static ShoppingItem fromMap(Map<String, dynamic> map){
    return new ShoppingItem(map['id'],
        map['id'],
        map['date'],
        map['cost'],
        map['ticketsNum']);
  }


}