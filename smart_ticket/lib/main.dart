import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_ticket/helpers/StDbHelper.dart';
import 'package:smart_ticket/models/shoppingItem.dart';
import 'package:smart_ticket/scan.dart';
import 'package:smart_ticket/widgets/insertdialog.dart';
import 'package:smart_ticket/widgets/shoppingitemwidget.dart';

void main() => runApp(new SmartTicketApp());

class SmartTicketApp extends StatelessWidget {
  // This widget is the root of your application.

  static var colorPrimary = Colors.orange[700];
  static var colorPrimaryDark = Colors.orange[800];
  static var colorAccent = Colors.orange[900];
  static var greyBkg = Colors.grey[50];

  static var appTitle = "Smart Ticket";

  static const String ROUTE_HOME = "/";
  static const String ROUTE_SCAN = "/scan";
  static const String ST_CHANNEL = "smartTicket";
  static const String OCR_METHOD = "startOcr";

  static var primarySwatch = MaterialColor(0xFFF57C00, // colorPrimary.value,
      {
        50: colorPrimary,
        100: colorPrimary,
        200: colorPrimary,
        300: colorPrimary,
        400: colorPrimary,
        500: colorPrimary,
        600: colorPrimaryDark,
        700: colorAccent,
        800: colorAccent,
        900: colorAccent
      });

  final ThemeData androidThemeData = ThemeData(
      primarySwatch: primarySwatch,
      iconTheme: IconThemeData(color: Colors.white),
      primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white)));

  final isAndroid = defaultTargetPlatform == TargetPlatform.android;

  static const plaformChannel = const MethodChannel(ST_CHANNEL);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: appTitle,
      theme: //TODO theme for ios
          androidThemeData,
      initialRoute: '/',
      routes: {
        //che è sto context tra parentesi?
        ROUTE_HOME: (context) => HomeScreen(title: appTitle),
        ROUTE_SCAN: (context) => ScanScreen(title: appTitle)
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, @required this.title}) : super(key: key);

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

class _HomeScreenState extends State<HomeScreen> {
  var itemsList;

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
      body: new Container(
        padding: EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              child: new Text("La mia spesa",
                  style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              margin: EdgeInsets.only(
                  top: 10.0, left: 10.0, right: 50.0, bottom: 15),
            ),
            new Container(child: _buildItemList())
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: SmartTicketApp.colorAccent,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: addNewItem),
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  FutureBuilder _buildItemList() {
    debugPrint("Fetching ShoppingItems");
    return FutureBuilder(
      future: StDbHelper().getAllItems(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return createListView(context, snapshot);
        } else
          return Expanded(child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    itemsList = snapshot.data as List<ShoppingItem>;
    if (itemsList.isEmpty) {
      return Expanded(
          child: Center(
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
      ));
    } else {
      return Expanded(
          child: Center(
        child: ListView.builder(
            itemCount: itemsList.length,
            itemBuilder: (context, item) {
              return Dismissible(
                  key: Key('${item.hashCode}'), //TODO valuta se va o no

                  onDismissed: (direction) {
                    setState(() => removeItem);
                  },
                  child: ShoppingItemWidget(itemsList[item]));
            }),
      ));
    }
  }

  void addNewItem() {
    //TODO mostrare dialog che chiede il nome, generare oggetto e aggiungere a db, e pusha a scan
    //TODO crea custom widget dialog? per inserire i dati
    showDialog(
        context: context,
        builder: (context) {
          //Todo return insertdialog
          return InsertDialog(SmartTicketApp.ROUTE_SCAN);
        });
  }

  void removeItem(int id) {
    var removedItem = (itemsList as List).removeAt(id);
    StDbHelper().removeShoppingItem(removedItem);
    //TODO gestisci direction
  }
}
