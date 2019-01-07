import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_ticket/main.dart';
import 'package:smart_ticket/models/shoppingItem.dart';
import 'package:smart_ticket/scan.dart';

class ShoppingItemWidget extends StatelessWidget {
  final ShoppingItem item;

  ShoppingItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    // TODO: implement swipe to dismiss + dragdrop
    return Card(
        elevation: SmartTicketApp.defaultCardElevation,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: InkWell(
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ScanScreen(item))
            );
          },
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(item.name, style: SmartTicketApp.headerText),
                    Text(_parseData(item.date))
                  ],
                ),
                new Divider(
                  color: Colors.grey,
                ),
                Row(
                  children: <Widget>[
                    Text('${item.cost.toStringAsFixed(2)}€',
                        style: TextStyle(
                            fontSize:
                                15)) //TODO currency based on locale/location
                  ],
                )
              ],
            ),
          ),
        ));
  }

  String _parseData(String timestamp) {
    //TODO fai bene con stringhe intl
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    return '${date.day}/${date.month}/${date.year}';
  }
}
