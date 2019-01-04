import 'package:flutter/material.dart';
import 'package:smart_ticket/models/product.dart';
import 'package:smart_ticket/models/productsearchitem.dart';
import 'package:smart_ticket/models/shoppingItem.dart';

class ProductSearchWidget extends StatefulWidget {
  ProductSearchItem _item;
  ShoppingItem _shoppingItem;

  ProductSearchWidget(this._item, this._shoppingItem);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductSearchWidgetState();
  }
}

class ProductSearchWidgetState extends State<ProductSearchWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
    InkWell(
      onTap: (){},
        child:
      Column(
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
                    Icons.add_circle_outline,
                    size: 30,
                    color: Colors.grey[600],
                  ),
                  onPressed: (){
                    setState(() {
                    manageProduct();
                  });}),
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
          Divider(height: 2,)
        ],
      )
    );
  }

  void manageProduct(){
    //aggiunge o rimuove
    //TODO cosa fare con il db? aggiungo ora? dopo?
    
    //Creo product attuale
    var product = Product.generate(widget._item.name);
    widget._shoppingItem.addProduct(product);

    debugPrint("Added product ${product.name},"
        " shoppingList has now ${widget._shoppingItem.products.length} items");

    //TODO insert product?

  }

}
