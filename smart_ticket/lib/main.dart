import 'package:flutter/material.dart';
import 'package:smart_ticket/helpers/StDbHelper.dart';
import 'package:smart_ticket/models/shoppingItem.dart';
import 'package:smart_ticket/scan.dart';
import 'package:smart_ticket/widgets/shoppingitemwidget.dart';

void main() => runApp(new SmartTicketApp());

class SmartTicketApp extends StatelessWidget {
  // This widget is the root of your application.

  static var colorPrimary = Colors.orange[700];
  static var colorPrimaryDark = Colors.orange[800];
  static var colorAccent = Colors.orange[900];
  static var greyBkg = Colors.grey[50];

  static var appTitle = "Smart Ticket";

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

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: appTitle,
      theme: //TODO theme for ios
          androidThemeData,
      initialRoute: '/',
      routes: {
        //che è sto context tra parentesi?
        '/': (context) => HomeScreen(title: appTitle),
        '/scan': (context) => ScanScreen()
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

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
              margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 50.0),
            ),
            _buildItemList()
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: SmartTicketApp.colorAccent,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: _incrementCounter),
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

  FutureBuilder _buildItemList(){
    return FutureBuilder(
      future: StDbHelper().getAllItems(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return createListView(context, snapshot);
        }
        else return Expanded(child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot){
    //TODO se lista vuota ritorna coso carino else ritorna lista
      final itemsList = snapshot.data as List<ShoppingItem>;
    if(itemsList.isEmpty){
      return new Center(
        child: Column(
          children: <Widget>[
             Text("TODO inserisci immagine carina"), //todo lo sai
             Text("Oops! Non ci sono elementi qui.",
            style: TextStyle(fontSize: 16.0),)
          ],
        ),
      );
    }
    else {
      return ListView.builder(
        itemCount: itemsList.length,
        itemBuilder: (context, item) {
          return ShoppingItemWidget(itemsList[item]);
        });
    }
  }

}
