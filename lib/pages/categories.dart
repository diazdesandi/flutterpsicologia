import 'package:flutter/material.dart';

class CatPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return CatPageState();
  }
}

class CatPageState extends State<CatPage>{
  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.all(25.0),
      child: Text("Categories", style: TextStyle(fontSize: 36.0),),
    );
  }
}