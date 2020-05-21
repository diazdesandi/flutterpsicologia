import 'package:flutter/material.dart';
import './pages/home.dart';
import './pages/categories.dart';
import './pages/search.dart';
void main() => runApp(new xd_menu());
class xd_menu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return xd_menustate();
  }
}
class xd_menustate extends State<xd_menu> {
  int _selectedTab = 0;
  final _pageOptions = [
    HomePage(),
    CatPage(),
    SearchPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryTextTheme: TextTheme(
            title: TextStyle(color: Colors.white),
          )),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Menú'),
        ),
        body: _pageOptions[_selectedTab],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: (int index) {
            setState(() {
              _selectedTab = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text('Categories'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }}