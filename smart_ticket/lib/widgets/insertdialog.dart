import 'package:flutter/material.dart';
import 'package:smart_ticket/helpers/StDbHelper.dart';
import 'package:smart_ticket/models/shoppingItem.dart';

class InsertDialog extends Dialog{

  final String nextRoute;

  InsertDialog(this.nextRoute);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: new Text("Nuova spesa"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: "Nome",
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(child: Text("Crea"),
          onPressed: () {
          //TODO insert DB
            StDbHelper().addShoppingItem(ShoppingItem.generate("Prendi nome da txtfield"));

            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(nextRoute);
          },)
      ],
    );
  }

}