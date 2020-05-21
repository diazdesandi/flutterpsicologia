import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'pages/chat.dart';
import 'pages/feed.dart';
import 'pages/home.dart';
import 'pages/perfil.dart';
import 'pages/videos.dart';

void main() => runApp(MaterialApp(home: BottomNavBar()));

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 2;
  GlobalKey _bottomNavigationKey = GlobalKey();


  // Creacion de paginas
  final chat _messages = chat();
  final feed _articulos = feed();
  final home _menu = home();
  final perfil _info = perfil();
  final videos _vids = videos();

  Widget _menuprincipal = new home();
  
  Widget _selector(int page){
    switch(page){
      case 0:
      return _messages;
      break;
      case 1:
      return _articulos;
      break;
      case 2:
      return _menu;
      break;
      case 3:
      return _vids;
      break;
      case 4:
      return _info;
      break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: pageIndex,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.message, size: 30, color: Colors.white),
            Icon(Icons.rss_feed, size: 30, color: Colors.white),
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.ondemand_video, size: 30, color: Colors.white,),
            Icon(Icons.perm_identity, size: 30, color: Colors.white,),
          ],
          color: Colors.redAccent,
          buttonBackgroundColor: Colors.redAccent,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (int tappedIndex) {
            setState(() {
              _menuprincipal = _selector(tappedIndex);
            });
          },
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: _menuprincipal,
          ),
        ));
  }
}