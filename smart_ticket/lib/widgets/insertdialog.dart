import 'package:flutter/material.dart';
import 'package:smart_ticket/helpers/StDbHelper.dart';
import 'package:smart_ticket/main.dart';
import 'package:smart_ticket/models/shoppingItem.dart';

class InsertDialog extends Dialog {
  final String nextRoute;

  String
      itemName; //TODO poi cisarà da gestire l'intero form, sfanculando questa meccanica

  InsertDialog(this.nextRoute);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 20.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      title: new Text("Nuova spesa"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            onChanged: (newText) {
              itemName = newText;
            },
            decoration: InputDecoration(
              labelText: "Nome",
            ),
          ),
          Container(margin: EdgeInsets.only(bottom: 15)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
                child: FlatButton(
              color: SmartTicketApp.colorPrimary,
              textColor: Colors.white,
              child: Text("CREA"),
              onPressed: () {
                //TODO insert DB
                StDbHelper().addShoppingItem(ShoppingItem.generate(itemName));

                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(nextRoute);
              },
            ))
          ])
        ],
      ),
    );
  }
}
