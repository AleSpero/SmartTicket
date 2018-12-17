import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_ticket/models/shoppingItem.dart';


class ShoppingItemWidget extends StatelessWidget{

  final ShoppingItem item;

  final TextStyle headerText = TextStyle(
    fontSize: 18,
        fontWeight: FontWeight.w800,
    color: Colors.black54
  );


  ShoppingItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      margin: EdgeInsets.all(12),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Text(item.name,
              style: headerText),
              Text(_parseData(item.date))
            ],),
            new Divider(color: Colors.grey,),
            Row(children: <Widget>[
              Text('${item.cost}€',
              style : TextStyle(fontSize: 15)) //TODO currency based on locale/location
            ],)
          ],
        ),
      ),
    );
  }

  String _parseData(String timestamp){
    //TODO fai bene con stringhe intl
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    return '${date.day}/${date.month}/${date.year}';
  }

}