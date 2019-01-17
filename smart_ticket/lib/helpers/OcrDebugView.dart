import 'package:flutter/material.dart';
import 'package:smart_ticket/models/product.dart';
import 'package:smart_ticket/models/shoppingItem.dart';
import 'package:smart_ticket/widgets/productwidget.dart';

class OcrDebugView extends StatefulWidget {

  OcrDebugView(this.item);

  ShoppingItem item;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OcrDebugViewState();
  }
}

class OcrDebugViewState extends State<OcrDebugView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Center(
              child: TextField(
                key: Key("priceTextInput"), //TODO string
            style: TextStyle(fontSize: 30, color: Colors.black),
            keyboardType:
                TextInputType.numberWithOptions(signed: false, decimal: true),
                decoration: InputDecoration(hintText: "23,45€"),
          ))),
      floatingActionButton: FloatingActionButton(
          onPressed: _validatePrice,
          child: Icon(
            Icons.check,
            color: Colors.white,
          )),
    );
  }

  void _validatePrice(){

    debugPrint(widget.item.toString());

    showDialog(
        context: context,
        builder: (context) {
          // TODO: implement build
          return AlertDialog(
              contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 20.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              title: new Text("Seleziona l'elemento scansionato"),
              content: Container(
                width: 300,
                  height: 300, //TODO hmm check for small displays
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                return ProductWidget(widget.item.products[index], widget.item, ProductWidget.STYLE_SCANSCREEN,
                onTap: checkProduct);
                //TODO aggiungi qui callback on checked?
              },
              itemCount: widget.item.products.length),
              )
          );
        });
  }

void checkProduct(){
    //Pop dialog
    //Ora dovrebbe essere un product
    //TODO query db: PRima aggiorna product con costo e checked state a 1, poi salvalo sul db e poppa
   // Product product = _item as Product;

    //product.cost =

    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

}
