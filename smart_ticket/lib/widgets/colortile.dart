import 'package:flutter/material.dart';

class ColorTile extends StatelessWidget{

  //TOdo costruttore?

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
        child:
        ListTile(
      leading: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
        color: Colors.blue, //TODO selected color
          shape: BoxShape.circle
      ),
      ),
      title: Text("Blue"),
    ),
      onTap: (){debugPrint("implement me baby");}
    );
  }

}