import 'package:flutter/material.dart';
import 'package:smart_ticket/models/productsearchitem.dart';

class ProductSearchWidget extends StatefulWidget{

  ProductSearchItem _item;

  ProductSearchWidget(this._item);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductSearchWidgetState();
  }

}

class ProductSearchWidgetState extends State<ProductSearchWidget>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(widget._item.name);
  }

}