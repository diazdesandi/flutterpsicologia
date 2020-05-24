import 'package:flutter/material.dart';
import 'package:flutterpsicologia/paginas/youtubevideodata/pantallas/homevideo.dart';

void videos() => runApp(clasevideos());

class clasevideos extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Videos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: HomeScreen(),
    );
  }
}