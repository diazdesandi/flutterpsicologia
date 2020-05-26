import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'getrss.dart';
import 'NewsDetails.dart';

void mainz() => runApp(MyFeed());

class MyFeed extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Articulos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: FeedHP(title: 'Articulos'),
    );
  }
}

class FeedHP extends StatefulWidget {
  FeedHP({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FeedHPState createState() => _FeedHPState();
}

class _FeedHPState extends State<FeedHP> {

  @override
  Widget build(BuildContext context) {
    setState(() {
      GetRSS.gettrss();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
            future: GetRSS.gettrss(),
            builder: (buildcontext, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text( 'Obteniendo articulos', style: GoogleFonts.robotoMono(fontSize: ScreenUtil.getInstance().setSp(30),
                       ),
                       ),
                      ],
                    ),
                  );
                  break;
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                  return Container(
                    child: ListView.separated(
                        itemBuilder: (context, int index) {
                          String url;
                          if (snapshot.data[index].urlImage != "") {
                            url = snapshot.data[index].urlImage;
                          } else {
                            url =
                                "https://graffica.info/wp-content/uploads/2014/02/newsEN_welcome-21.png";
                          }
                          return ListTile(
                            leading: Image.network(url),
                            title: Text(
                              snapshot.data[index].titulo,
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black54),
                            ),
                            subtitle: Text(
                              snapshot.data[index].fecha,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsDetails(
                                    title: "Articulo",
                                    url: snapshot.data[index].urlNoticias,
                                    key: null,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                              color: Colors.grey,
                            ),
                        itemCount: snapshot.data.length),
                  );
                  break;
              }
            }),
      ),
    );
  }
}
