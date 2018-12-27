import 'package:flutter/material.dart';
import 'package:smart_ticket/helpers/StDbHelper.dart';
import 'package:smart_ticket/main.dart';
import 'package:smart_ticket/models/shoppingItem.dart';
import 'package:smart_ticket/widgets/colortile.dart';

class InsertDialog extends StatefulWidget {
  final String nextRoute;

  InsertDialog(this.nextRoute);

  @override
  InsertDialogState createState() {
    return InsertDialogState();
  }
}

class InsertDialogState extends State<InsertDialog>{

  ShoppingItem newItem = ShoppingItem();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child:
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  labelText: "Nome",
                  //border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.label)
              ),
             /* validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'Inserisci un nome.';
                }
              }, in realtà non serve ad una mazza il validator in questo caso, rip*/
              onSaved: (value) {
                if(value.isNotEmpty)
                newItem.name = value;
              },
              autovalidate: true,
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: "Note",
                  //border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.short_text)
              ),
                onSaved: (value) {
                  if(value.isNotEmpty)
                    newItem.notes = value;
                }
            ),
            ColorTile(),
            Container(margin: EdgeInsets.only(bottom: 15)),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                  child: FlatButton(
                    color: SmartTicketApp.colorPrimary,
                    textColor: Colors.white,
                    child: Text("CREA"),
                    onPressed: /*_formKey.currentState != null && _formKey.currentState.validate() ?*/
                            _validateDialog /* : null Lascio commentato solo come esempio per form futuri*/
                  ))
            ])
          ],
        )
    );
  }

  void _validateDialog(){
      _formKey.currentState.save();
      //TODO crea oggetto vuoto all'inizio di build e poi nell'onsaved di ogni text field aggiungi campi, infine fai solo insert
      debugPrint(newItem.toMap().toString());
      StDbHelper().addShoppingItem(newItem);

      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(SmartTicketApp.ROUTE_SCAN);
    }

    //valido widget


  }

