import 'package:flutter/material.dart';
import 'package:smart_ticket/helpers/StDbHelper.dart';
import 'package:smart_ticket/models/productsearchitem.dart';

class ProductSearchDelegate extends SearchDelegate {

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(icon: Icon(Icons.close),
      onPressed: () {
        query = '';
      },),
      IconButton(
        icon: Icon(Icons.mic),
        onPressed: (){},
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text("Implement me");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return FutureBuilder(
      future: StDbHelper().getAllHintProducts(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }
        else{
          List<ProductSearchItem> hintList = snapshot.data as List;
          List<ProductSearchItem> finalList = hintList.where((item) =>
              item.name.toLowerCase().startsWith(query.toLowerCase())).toList();

          return ListView.builder(
              itemCount: finalList.length,
              itemBuilder: (context, index){
              return Text(finalList[index].name);
          });
        }
      },
    );
  }

}