import 'package:flutter/material.dart';

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
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(nextRoute);
          },)
      ],
    );
  }

}