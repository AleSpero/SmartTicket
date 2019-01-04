import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smart_ticket/helpers/CustomShapeClipper.dart';
import 'package:smart_ticket/helpers/StDbHelper.dart';
import 'package:smart_ticket/helpers/productsearchdelegate.dart';
import 'package:smart_ticket/main.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:smart_ticket/models/productsearchitem.dart';
import 'package:smart_ticket/models/shoppingItem.dart';

class AddProductScreen extends StatefulWidget {

  AddProductScreen(this.currentItem,{Key key, this.title}) : super(key: key);

  final ShoppingItem currentItem;
  final String title;

  List<ProductSearchItem> hintProducts = List<ProductSearchItem>();

  @override
  _AddProductScreenState createState() => new _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {

    _initHintList();

    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
          title: new Text("Aggiungi Prodotto"),
          //elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                setState(() {

                showSearch(
                    context: context,
                    delegate: ProductSearchDelegate(widget.currentItem)
                );
                });
              }
            )
          ]),

      body: Container(
          child: Column(
            children: <Widget>[
             Text("${widget.currentItem.products.length}")
            ],
          )),
     // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: SmartTicketApp.colorAccent,
          child: Icon(Icons.arrow_forward, color: Colors.white),
          onPressed: (){
            setState(() {

            });
          }),
      /*bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        color: SmartTicketApp.colorPrimary,
        child: Row(
          //TODO?
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.history, color: Colors.white), onPressed: null)
          ],
        ),
      ),*/ // / This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _initHintList(){
 /*   if(widget.hintProducts.isEmpty){
      //Init hint products list
      StDbHelper().getAllHintProducts().then((list){
        widget.hintProducts = list;
      });
    }
  */}

}
