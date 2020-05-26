import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'paginas/feed.dart';
import 'paginas/home.dart';
import 'paginas/videos.dart';

void main() => runApp(MaterialApp(home: BottomNavBar()));

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 1;
  GlobalKey _bottomNavigationKey = GlobalKey();


  // Creacion de paginas
  final MyFeed _articulos = MyFeed();
  final Home _menu = Home();
  final ClaseVideos _vids = ClaseVideos();

  Widget _menuprincipal = new Home();
  
  Widget _selector(int page){
    switch(page){
      case 0:
      return _articulos;
      break;
      case 1:
      return _menu;
      break;
      case 2:
      return _vids;
      break;
      default:
      return _menu;
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
            Icon(Icons.rss_feed, size: 30, color: Colors.white),
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.ondemand_video, size: 30, color: Colors.white,),
          ],
          color: Colors.redAccent,
          buttonBackgroundColor: Colors.redAccent,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (int tappedIndex) {
            setState(() {
              _menuprincipal = _selector(tappedIndex);
            });
          },
        ),
        body: Container(
          color: Colors.transparent,
          child: Center(
            child: _menuprincipal,
          ),
        ));
  }
}