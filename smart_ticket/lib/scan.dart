import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smart_ticket/addproduct.dart';
import 'package:smart_ticket/helpers/CustomShapeClipper.dart';
import 'package:smart_ticket/helpers/OcrDebugView.dart';
import 'package:smart_ticket/helpers/StDbHelper.dart';
import 'package:smart_ticket/helpers/TicketUtils.dart';
import 'package:smart_ticket/main.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:smart_ticket/models/product.dart';
import 'package:smart_ticket/models/baseproduct.dart';
import 'package:smart_ticket/models/shoppingItem.dart';
import 'package:smart_ticket/widgets/CustomBottomAppBar.dart';
import 'package:smart_ticket/widgets/productwidget.dart';

class ScanScreen extends StatefulWidget {
  ScanScreen(this.currentItem, {Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  ShoppingItem currentItem;//TODO temp

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<ScanScreen> {

  double priceDifference= 0;
  int ticketsNum = 0;

  @override
  Widget build(BuildContext context) {

    //TODO rivedi bene sta roba

    /*TicketUtils.calculateDifferenceAsync(widget.currentItem.cost).then((diff){
      priceDifference = diff;
      if(priceDifference == 0)
      setState((){});
    });*/

    /*TicketUtils.getTicketPrice().then((price){
      ticketsNum = (widget.currentItem.cost/price).round();
      if(ticketsNum == 0)
        setState((){});
    });*/

    return new Scaffold(
      appBar: new AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: new Text("Spesa"),
          elevation: 0.0,
          actions: <Widget>[
            PopupMenuButton(
              itemBuilder: (context) {},
              icon: Icon(Icons.more_vert, color: Colors.white),
            )
          ]),

      body: Container(
          child: ListView(children: <Widget>[
        createTopCard(),
          Card(
            elevation: SmartTicketApp.defaultCardElevation,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            margin: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            child: Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      alignment: Alignment.centerLeft,
                      child: Text("Prodotti", style: SmartTicketApp.headerText),
                    ),
                    _buildProductsList()
                  ],
                )),
          ),
      ])),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Hero(tag:"PROVA", child:  FloatingActionButton.extended(
          backgroundColor: SmartTicketApp.colorPrimary,
          icon: Icon(Icons.search, color: Colors.white),
          label: Text("Scansiona", style: TextStyle(color: Colors.white),),
          onPressed: scanItem),
      ),
      bottomNavigationBar: Hero(
        tag: SmartTicketApp.HERO_TAG_BOTTOMAPPBAR,
    child: CustomBottomAppBar(
        color: Colors.grey[800],
        selectedColor: SmartTicketApp.colorPrimary,
        onTabSelected: (tabIndex){},
        items: [
          CustomBottomAppBarItem(icon: Icons.shopping_cart, label: "Spesa"),
          CustomBottomAppBarItem(icon: Icons.person_outline, label: "Profilo"),
          CustomBottomAppBarItem(icon: Icons.insert_chart, label: "Budget"),
          CustomBottomAppBarItem(icon: Icons.person_outline, label: "Profilo")
        ],
      ),
      )// / This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void scanItem() async {

    if(!SmartTicketApp.isAndroid || true){


      int selectedProductId = await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OcrDebugView(widget.currentItem)
      ));

      //Condizione if prezzo > 0 potrebbe essere debole

    }
    else {
      try {
        //Check permission!
        var hasPermission =
        await SimplePermissions.checkPermission(Permission.Camera);

        if (!hasPermission) {
          //Request It
          var permissionStatus =
          await SimplePermissions.requestPermission(Permission.Camera);
          debugPrint(permissionStatus.toString());
        }

        SmartTicketApp.plaformChannel.invokeMethod(SmartTicketApp.OCR_METHOD);
        //TODO ios!
      } catch (PlatformException) {
        //TODO error
      }
    }
  }

  Widget createTopCard() {

    //TicketUtils.calculateNumTickets

    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 150,
            decoration: BoxDecoration(color: SmartTicketApp.colorPrimary),
          ),
        ),
        new Card(
          elevation: SmartTicketApp.defaultCardElevation,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    alignment: Alignment.centerLeft,
                    child: Text("Subtotale", style: SmartTicketApp.headerText),
                  ),

                  Container(
                    child: Text(
                      '${widget.currentItem.cost.toStringAsFixed(2)}€',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                  Text(
                    "Servono ${TicketUtils.calculateNumberOfTickets(widget.currentItem.cost, SmartTicketApp.ticketPrice)} Ticket",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "E una differenza di ${TicketUtils.calculateDifference(widget.currentItem.cost).toStringAsFixed(2)}€",
                    //TODO valuta metodo in ticketutils
                    //style: TextStyle(fontSize: ),
                  )
                  //createBudgetView()
                ],
              )),
        ),
      ],
    );
  }

  Widget _buildProductsList() {
    //debugPrint("Fetching products for Shoppingitem with id ${widget.currentItem.id}");
    return FutureBuilder(
        future: StDbHelper().getProductsById(widget.currentItem.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Flexible(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                createListView(context, snapshot),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              AddProductScreen(widget.currentItem)));
                      //.pushNamed(SmartTicketApp.ROUTE_ADD_PRODUCT);
                    },
                    child: Text("AGGIUNGI"),
                    textColor: SmartTicketApp.colorPrimary)
              ],
            ));
          } else
            return Center(child: CircularProgressIndicator());
        });
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Product> productsList = snapshot.data as List<Product>;

    //sorto per checkato/non checkato (prezzo /non prezzo)
    productsList.sort((a,b) => a.cost.toInt() - b.cost.toInt());
    widget.currentItem.products = productsList;
    //debugPrint('${productsList.isEmpty}');
    if (productsList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image.asset('assets/icons/no_products.png',
                width: 100, height: 100),
            Container(
                child: Text("Oops! Non ci sono elementi qui.",
                    style: TextStyle(fontSize: 16.0)),
                padding: EdgeInsets.all(15))
          ],
        ),
      );
    } else {
      return Container( child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: productsList.length,
                  itemBuilder: (context, index) {
                    //TODO refactoring model object db pls (product widget prende un baseproduct,
                    //che può essere sia normale che il product che aggiungo effettivamente))

                    return Dismissible(
                     key: Key('${index.hashCode}'),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                       //TODO remove per bene
                        productsList.removeAt(index);
                      }, //TODO scroll smooth physics coso
                      background: Container(color: Colors.red[600],
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.delete)),
                      child: ProductWidget(productsList[index], widget.currentItem, ProductWidget.STYLE_SCANSCREEN,
                       onTap: /*TODO in fondo alla lista*/null)
                    );

                  })
      );
    }
  }
}
