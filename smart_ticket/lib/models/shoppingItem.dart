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

  Map<String, dynamic> toMap(){
    return {
      'id' : _id,
      'date' : _date,
      'name' : _name,
      'cost' : _cost,
      'ticketsNum' : _ticketsNum
    };
  }


}