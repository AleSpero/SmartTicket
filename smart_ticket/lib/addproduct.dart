import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smart_ticket/helpers/CustomShapeClipper.dart';
import 'package:smart_ticket/main.dart';
import 'package:simple_permissions/simple_permissions.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<AddProduct> {
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
            decoration: BoxDecoration(
                color: SmartTicketApp.colorPrimary
            ),
          ),
        ),
        new Card(
          elevation: 6.0,
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
                    child: Text("Subtotale",
                        style: SmartTicketApp.headerText),
                  ),

                  Container(
                    child: Text(
                      "23,40€",
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                  Text(
                    "Hai usato x Ticket",
                    style: TextStyle(fontSize: 18),
                  ),
                  LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 100,
                    animation: true,
                    lineHeight: 20.0,
                    animationDuration: 2000,
                    percent: 0.4, //TODO calculate budget percent
                    center: Text("40.0%", style: TextStyle(color: Colors.white),), //TODO idem con patate
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: SmartTicketApp.colorAccent,
                  ),
                  //createBudgetView()
                ],
              )
          ),
        ),
      ],
    );
  }
}
