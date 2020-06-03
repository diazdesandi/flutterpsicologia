import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'rssfiles/NewsDetails.dart';
import 'rssfiles/getrss.dart';

void mainz() => runApp(MyFeed());

class MyFeed extends StatelessWidget {
  // Este widget se utiliza para la interfaz principal donde estan las tres secciones, articulos, home, reproductor de videos
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

//este widget se utiliz apara el evento cuando precionamos la pantalla con la cual se lanazara el RSSFEED
class FeedHP extends StatefulWidget {
  FeedHP({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FeedHPState createState() => _FeedHPState();
}
//esta clase nbos sirve para traer la informacion que creamos en la clase GetRSS a la pantalla principal
class _FeedHPState extends State<FeedHP> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      GetRSS.gettrss();
    });
    //Esta seccion nos sirve para el acomodo front end de la informacion, tener centrada la informacion de los contenedores
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          //Aqui llamamos al evento future que se hizo en el modulo 
          //gettrss, se corre esta operacion y el future en gettsss llama a toda la informacion
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
                        Text(
                          'Obteniendo articulos',
                          style: GoogleFonts.robotoMono(
                            fontSize: ScreenUtil.getInstance().setSp(30),
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
                    //esta seccion crea la vista en tipo lista para que la informacion se muestre de esta manera
                    child: ListView.separated(
                        itemBuilder: (context, int index) {
                          String url;
                          //esta es una condicion que nos trae la imagen desde la pagina http y si no la 
                          //puede traer llamara una imagen para que el espacio de imagen no quede vacio, la imagen puede 
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
