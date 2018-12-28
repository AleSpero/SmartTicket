import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smart_ticket/helpers/CustomShapeClipper.dart';
import 'package:smart_ticket/helpers/StDbHelper.dart';
import 'package:smart_ticket/main.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:smart_ticket/models/product.dart';
import 'package:smart_ticket/models/shoppingItem.dart';

class ScanScreen extends StatefulWidget {
  ScanScreen({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  ShoppingItem currentItem = ShoppingItem(); //TODO temp

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
          child: Column(
        children: <Widget>[
          createTopCard(),
          new Card(
            elevation: SmartTicketApp.defaultCardElevation,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            margin: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      alignment: Alignment.centerLeft,
                      child: Text("Prodotti", style: SmartTicketApp.headerText),
                    ),
                    Container(child: _buildProductsList())
                  ],
                )),
          ),
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: SmartTicketApp.colorAccent,
          child: Icon(Icons.search, color: Colors.white),
          onPressed: scanItem),
      bottomNavigationBar: BottomAppBar(
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
      ), // / This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void scanItem() async {
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
    } catch (PlatformException) {
      //TODO error
    }
  }

  Widget createTopCard() {
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
          margin: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
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
                    "Hai usato ${widget.currentItem.ticketsNum} Ticket",
                    style: TextStyle(fontSize: 18),
                  ),
                  LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 100,
                    animation: true,
                    lineHeight: 20.0,
                    animationDuration: 2000,
                    percent: 0.4,
                    //TODO calculate budget percent che cos'era sta roba?
                    center: Text(
                      "40.0%",
                      style: TextStyle(color: Colors.white),
                    ),
                    //TODO idem con patate
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: SmartTicketApp.colorAccent,
                  ),
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
            return Column(
              children: <Widget>[
                createListView(context, snapshot),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(SmartTicketApp.ROUTE_ADD_PRODUCT);
                    },
                    child: Text("AGGIUNGI"),
                    textColor: SmartTicketApp.colorPrimary)
              ],
            );
          } else
            return Center(child: CircularProgressIndicator());
        });
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List productsList = snapshot.data as List<Product>;
    //debugPrint('${productsList.isEmpty}');
    if (productsList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image.asset('assets/no_items.png', width: 150, height: 150),
            Container(
                child: Text("Oops! Non ci sono elementi qui.",
                    style: TextStyle(fontSize: 16.0)),
                padding: EdgeInsets.all(15))
          ],
        ),
      );
    } else {
      return Center(
        child: ListView.builder(
            itemCount: productsList.length,
            itemBuilder: (context, index) {
              return Text("daje");
            }),
      );
    }
  }
}
