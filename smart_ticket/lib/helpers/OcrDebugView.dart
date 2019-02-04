import 'package:flutter/material.dart';
import 'package:smart_ticket/helpers/StDbHelper.dart';
import 'package:smart_ticket/models/product.dart';
import 'package:smart_ticket/models/shoppingItem.dart';
import 'package:smart_ticket/widgets/productwidget.dart';

class OcrDebugView extends StatefulWidget {
  OcrDebugView(this.item);

  ShoppingItem item;
  String productPrice = "0";
  TextEditingController textController = TextEditingController();

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
            onChanged: (text){
              setState(() {
                widget.productPrice = text;
                debugPrint(widget.productPrice);
              });
            },
            style: TextStyle(fontSize: 30, color: Colors.black),
            keyboardType:
                TextInputType.numberWithOptions(signed: false, decimal: true),
            decoration: InputDecoration(hintText: "23,45€"),
          ))),
      floatingActionButton: FloatingActionButton(
          onPressed: (){_validatePrice(widget.productPrice);},
          child: Icon(
            Icons.check,
            color: Colors.white,
          )),
    );
  }

  void _validatePrice(String newPrice) {
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
                    itemBuilder: (context, index) {
                      return ProductWidget(
                          widget.item.products[index],
                          widget.item,
                          ProductWidget.STYLE_SCANSCREEN, onTap: () {
                        checkProduct(widget.item.products[index],
                        newPrice);
                      });
                      //TODO aggiungi qui callback on checked?
                    },
                    itemCount: widget.item.products.length),
              ));
        });
  }

  void checkProduct(Product product, String price) {
    //Ora dovrebbe essere un product
    debugPrint('$price prezzo');
    product.cost = double.parse(price);

    //TODO chiedi quanti prodotti ci sono (nel dialog) magari con bottoncini per aumentare/diminuire
    StDbHelper().updateProduct(product);
    Navigator.of(context).pop();
    //Id del prodotto poppato
    Navigator.of(context).pop(product.id);
  }
}
