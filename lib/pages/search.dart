import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return SearchPageState();
  }
}

class SearchPageState extends State<SearchPage>{
  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.all(25.0),
      child: Text("Search", style: TextStyle(fontSize: 36.0),),
    );
  }
}