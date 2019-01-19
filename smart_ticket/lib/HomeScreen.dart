import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_ticket/helpers/CustomShapeClipper.dart';
import 'package:smart_ticket/main.dart';
import 'package:smart_ticket/models/baseproduct.dart';
import 'package:smart_ticket/models/shoppingItem.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  static final CARD_ELEVATION = 6.0;

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          elevation: 0,
          /*actions: <Widget>[
            PopupMenuButton(
              itemBuilder: (context) {},
              icon: Icon(Icons.more_vert, color: Colors.white),
            )
          ],*/
        ),
        body: Center(
            child:
                Column( children: [
          Stack(children: <Widget>[
            ClipPath(
              clipper: CustomShapeClipper(),
              child: Container(
                height: 550,
                decoration: BoxDecoration(color: SmartTicketApp.colorPrimary),
              ),
            ),
            Container(
                padding:
                    EdgeInsets.only(left: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Ciao, Alessandro!",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                    )
                  ],
                )),
        Container(
            margin: EdgeInsets.only(top: 100),
            child:
        GridView.count(
          shrinkWrap: true,
              crossAxisCount: 2,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(15),
                    child: HomeCard(
                      "Nuova Spesa",
                      Image.asset(
                        "assets/icons/shopping-cart.png",
                        width: 60,
                        height: 60,
                      ),
                    )),
                Container(
                    padding: EdgeInsets.all(15),
                    child: HomeCard(
                      "Le Mie Spese",
                      Image.asset(
                        "assets/icons/other.png",
                        width: 60,
                        height: 60,
                      ),
                      routeName: SmartTicketApp.ROUTE_SHOP,
                    )),
                Container(
                    padding: EdgeInsets.all(15),
                    child: HomeCard(
                        "I Miei Budget",
                        Image.asset(
                          "assets/icons/bars-chart.png",
                          width: 60,
                          height: 60,
                        ))),
                Container(
                    padding: EdgeInsets.all(15),
                    child: HomeCard(
                        "Impostazioni",
                        Image.asset(
                          "assets/icons/settings.png",
                          width: 60,
                          height: 60,
                        )))
              ],
            )
        )]),
        ])));
  }
}

class HomeCard extends StatelessWidget {
  Widget image;
  String routeName;
  String title;

  HomeCard(this.title, this.image, {this.routeName});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        elevation: 7.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: InkWell(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(padding: EdgeInsets.all(10), child: image),
              Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ))
            ],
          )),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          onTap: () {
            manageNavigation(context, routeName);
          },
        ));
  }

  void manageNavigation(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }
}
