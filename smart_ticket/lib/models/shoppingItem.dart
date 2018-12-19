import 'package:smart_ticket/models/product.dart';

class ShoppingItem {
  int _id;
  String _date;
  String _name;
  double _cost;
  int _ticketsNum;

  List<Product> products = new List<Product>();

  int get id => _id;

  String get date => _date;

  int get ticketsNum => _ticketsNum;

  double get cost => products.length > 0 ?
    products
      .map((product) => product.cost)
      .reduce((current, next) => current + next) : 0;


  String get name => _name;

  ShoppingItem(this._id, this._date, this._name, this._ticketsNum);

  ShoppingItem.generate(String name) {
    this._date = '${DateTime.now().millisecondsSinceEpoch}';
    this._cost = 0;
    this._name = name;
    this._ticketsNum = 0;
  }

  Map<String, dynamic> toMap() {
    return {'date': _date, 'name': _name, 'ticketsNum': _ticketsNum};
  }

  ShoppingItem.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _date = map['date'];
    _name = map['name'];
    _ticketsNum = map['ticketsNum'];
  }
}
