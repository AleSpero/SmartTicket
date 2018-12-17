import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_ticket/models/shoppingItem.dart';


class ShoppingItemWidget extends StatelessWidget{

  final ShoppingItem item;

  ShoppingItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(child: Text(item.name));
  }

}