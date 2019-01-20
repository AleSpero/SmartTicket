import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();

}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Impostazioni"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("Alessandro Sperotti",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30)),
          CircleAvatar(),
          Divider(),
          ListView(
            shrinkWrap: true,
            children: <Widget>[
            ListTile(leading: Icon(Icons.confirmation_number), title: Text("Costo Ticket"),),
            TextField(onChanged: (newValue){
              setTicketPrice(newValue);
            },)
          ],)
        ],
      )),
    );
  }

  void setTicketPrice(String price) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble("ticketPrice", double.parse(price));
  }

}
