import 'package:flutter/material.dart';
import 'package:smart_ticket/helpers/StDbHelper.dart';
import 'package:smart_ticket/models/product.dart';
import 'package:smart_ticket/models/baseproduct.dart';
import 'package:smart_ticket/models/shoppingItem.dart';

class ProductWidget extends StatefulWidget {

  static const STYLE_SCANSCREEN = 0;
  static const STYLE_ADDSCREEN = 1;
 // static const STYLE_FROMDIALOG = 2;

  VoidCallback onTap;

  dynamic _item; //TODO REFACTORING CON HIERACY base -> Product
  ShoppingItem _shoppingItem;

  bool checkBoxValue = false;
  int itemStyle;

  static var addedProductColor = Colors.red[600];
  static var removedProductColor = Colors.grey[600];
  static var disabledColor = Colors.grey[300];
  static var disabledColorHighlight = Colors.grey[500];

  ProductWidget(this._item, this._shoppingItem, this.itemStyle,{this.onTap});

  @override
  State<StatefulWidget> createState() {
    return ProductWidgetState();
  }
}

class ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {

    var isAddScreenStyle = widget.itemStyle == ProductWidget.STYLE_ADDSCREEN;

  //  var isFromDialog = widget.itemStyle == ProductWidget.STYLE_FROMDIALOG;

    var isAddedOrChecked = isAddScreenStyle ? (widget._shoppingItem.products
        .any((prod) => prod.name == widget._item.name)) : 
        (widget.checkBoxValue);


    return InkWell(
        onTap: () {
          setState() {
            manageProductAdd();
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              color: (isAddedOrChecked && !isAddScreenStyle) ? ProductWidget.disabledColor : Colors.white,
                padding: EdgeInsets.symmetric(horizontal: isAddScreenStyle? 10 : 0),
                child: Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                     getTrailingWidget(isAddScreenStyle, isAddedOrChecked),
                      Container(
                        child: Text(
                          widget._item.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: isAddScreenStyle? 16 : 14,
                              decoration: isAddedOrChecked && !isAddScreenStyle ? TextDecoration.lineThrough : TextDecoration.none),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: isAddScreenStyle ? 0 : 9),
                          padding: EdgeInsets.all(isAddScreenStyle? 20 : 5),
                          child: Image.asset(
                              'assets/icons/${widget._item.categoryIcon}',
                              height: isAddScreenStyle? 30 : 25,
                              width: isAddScreenStyle? 30 : 25,
                         // TODO trova quello giusto per scala di grigi colorBlendMode: BlendMode.multiply,
                          color: (isAddedOrChecked && !isAddScreenStyle) ? ProductWidget.disabledColorHighlight : null))
                    ]))),
            Divider(
              height: 2,
            )
          ],
        ));
  }

  void manageProductAdd() {
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

  void manageProductScan() {

  }

  Widget getTrailingWidget(bool displayAddBtn, bool isCheckedOrAdded){
    if(displayAddBtn){
     return IconButton(
          icon: Icon(
            isCheckedOrAdded
                ? Icons.remove_circle_outline
                : Icons.add_circle_outline,
            size: 30,
            color: isCheckedOrAdded ? ProductWidget.addedProductColor : ProductWidget.removedProductColor
          ),
          onPressed: widget.onTap
     );
              //manageProductAdd();

    }
    else{
      return Checkbox(value: widget.checkBoxValue,
          activeColor: ProductWidget.disabledColorHighlight,
          onChanged: (bool isChecked){
        setState(() {
          widget.checkBoxValue = isChecked;
          widget.onTap;
        });
      });
    }
  }


}
