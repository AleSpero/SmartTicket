import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smart_ticket/helpers/CustomShapeClipper.dart';
import 'package:smart_ticket/helpers/StDbHelper.dart';
import 'package:smart_ticket/main.dart';
import 'package:smart_ticket/models/shoppingItem.dart';
import 'package:smart_ticket/scan.dart';
import 'package:smart_ticket/widgets/insertdialog.dart';
import 'package:smart_ticket/widgets/shoppingitemwidget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ShoppingItem> itemsList;
  List<ShoppingItemWidget> cardList;

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
        elevation: 0.0,
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (context) {

            },
            icon: Icon(Icons.more_vert, color: Colors.white),
          )
        ],
      ),
      body: new Container(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            createTopCard(),
            new Container(
              child: new Text("La mia spesa",
                  style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              margin: EdgeInsets.only(
                  top: 10.0, left: 10.0, right: 50.0, bottom: 15),
            ),
            new Container(
              child: _buildItemList())
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: SmartTicketApp.colorPrimary,
          icon: Icon(Icons.add, color: Colors.white),
          label: Text("Aggiungi", style: TextStyle(color: Colors.white)),
          onPressed: addNewItem),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 4.0,
        //color: SmartTicketApp.colorPrimary,
        child: Row(
          //TODO?
          children: <Widget>[
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
                new Image.asset('assets/icons/no_items.png', width: 150, height: 150),
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
                physics: BouncingScrollPhysics(),
                itemCount: itemsList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                      key: Key('${index.hashCode}'),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() =>
                            removeItem(itemsList[index], index, context));
                      },
                      child: ShoppingItemWidget(itemsList[index]));
                }),
          ));
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
          elevation: SmartTicketApp.defaultCardElevation,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Ciao, Alessandro!", //TODO nome utente? come faccio?
                        style: SmartTicketApp.mainCardHeaderText),
                  ),
                  Divider(color: Colors.grey),
                  createBudgetView()
                ],
              )
          ),
        ),
      ],
    );
  }

  Widget createBudgetView() {
    //TODO get budget info
    //TODO valuta notifiche budget?

    if (1 != 1) {
      //TODO if has budget set
      return Column(
        children: <Widget>[

          Container(child: Text("Questo mese hai speso 200,30€"),
            margin: EdgeInsets.only(top: 10),),
          LinearPercentIndicator(
            width: MediaQuery
                .of(context)
                .size
                .width - 100,
            animation: true,
            lineHeight: 20.0,
            animationDuration: 2000,
            percent: 0.4,
            //TODO calculate budget percent
            center: Text("40.0%", style: TextStyle(color: Colors.white),),
            //TODO idem con patate
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: SmartTicketApp.colorAccent,
          ),
          Text("Hai utilizzato 7 ticket"),
          LinearPercentIndicator(
            width: MediaQuery
                .of(context)
                .size
                .width - 100,
            animation: true,
            lineHeight: 20.0,
            animationDuration: 2000,
            percent: 0.7,
            //TODO calculate budget percent
            center: Text("70.0%", style: TextStyle(color: Colors.white),),
            //TODO idem con patate
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: SmartTicketApp.colorAccent,
          ),
        ],
      );
    }
    else {
      return
      Container(
      child:
        InkWell(
          child: Text(
            "Non hai ancora aggiunto un budget! \nTocca qui per farlo.",
            style: TextStyle(
                color: Colors.grey[700],
                fontSize: 12
            ),
            textAlign: TextAlign.center,),
          onTap: () {
            debugPrint("Implement me!");
          },
        ),
        margin: EdgeInsets.only(top: 10),
      );
    }
  }

  void addNewItem() {
    showDialog(
        context: context,
        builder: (context) {
          // TODO: implement build
          return AlertDialog(
              contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 20.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              title: new Text("Nuova spesa"),
              content: InsertDialog(SmartTicketApp.ROUTE_SCAN)
          );
        });
  }

  void removeItem(ShoppingItem item, int index, BuildContext scaffoldContext) {

    itemsList.remove(item);
    StDbHelper().removeShoppingItem(item);

    //Mostro snackbar
    Scaffold.of(scaffoldContext).showSnackBar(
        SnackBar(duration: Duration(milliseconds: 1500), content: Text("Spesa rimossa"),
            action: SnackBarAction(label: "Annulla", onPressed: () {
              setState(() {
                StDbHelper().addShoppingItem(item);
                itemsList.add(item);
              });
    })));

  }

}
