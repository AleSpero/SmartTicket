import 'package:flutter/material.dart';
import 'package:smart_ticket/helpers/StDbHelper.dart';
import 'package:smart_ticket/models/product.dart';
import 'package:smart_ticket/models/baseproduct.dart';
import 'package:smart_ticket/models/shoppingItem.dart';

class ProductWidget extends StatefulWidget {
  dynamic _item; //TODO REFACTORING CON HIERACY base -> Product
  ShoppingItem _shoppingItem;

  ProductWidget(this._item, this._shoppingItem);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductWidgetState();
  }
}

class ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    var isAdded = widget._shoppingItem.products
        .any((prod) => prod.name == widget._item.name);

    // TODO: implement build
    return InkWell(
        onTap: () {
          setState() {
            manageProduct();
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                      IconButton(
                          icon: Icon(
                            isAdded
                                ? Icons.remove_circle_outline
                                : Icons.add_circle_outline,
                            size: 30,
                            color: isAdded ? Colors.red[600] : Colors.grey[600],
                          ),
                          onPressed: () {
                            setState(() {
                              manageProduct();
                            });
                          }),
                      Container(
                        child: Text(
                          widget._item.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(20),
                          child: Image.asset(
                              'assets/icons/${widget._item.categoryIcon}',
                              height: 30,
                              width: 30))
                    ]))),
            Divider(
              height: 2,
            )
          ],
        ));
  }

  void manageProduct() {
    //aggiunge o rimuove

    //Creo product attuale
    var product = Product.generateWithCategory(widget._item.name, widget._item.categoryIcon);

    if (widget._shoppingItem.products.contains(product)) {
      //Rimuovo
      widget._shoppingItem.products.remove(product);
      StDbHelper().removeProduct(product);

      debugPrint("Removed product ${product.name},"
          " shoppingList has now ${widget._shoppingItem.products.length} items");
    } else {
      product.shoppingItemId = widget._shoppingItem.id;
      widget._shoppingItem.addProduct(product);

      debugPrint("Added product ${product.name},"
          " shoppingList has now ${widget._shoppingItem.products.length} items");

      StDbHelper().addProduct(product);
    }
  }
}
