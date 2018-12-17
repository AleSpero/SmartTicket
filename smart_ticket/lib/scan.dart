import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_ticket/main.dart';
import 'package:simple_permissions/simple_permissions.dart';

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
        title: new Text(widget.title),
      ),
      body: Container(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "23,40€",
            style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
          ),
          Text(
            "Hai usato x Ticket",
            style: TextStyle(fontSize: 18),
          )
          //TOdo fai fontstyle per le varie scritte
        ],
      ))),
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
}
