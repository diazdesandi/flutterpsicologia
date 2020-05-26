import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermodule/NewsDetails.dart';
import 'package:fluttermodule/getrss.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noticias',
      theme: ThemeData(

        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Noticias'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;



  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;



  @override
  Widget build(BuildContext context) {

    setState(() {
      getrss.Getrss();
    });

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: FutureBuilder(
            future: getrss.Getrss(),
              // ignore: missing_return
              builder:(BuildContext, AsyncSnapshot snapshot){
              switch(snapshot.connectionState){

                case ConnectionState.none:
                  // TODO: Handle this case.
                  break;
                case ConnectionState.waiting:
                  return Center(
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.cloud_download),
                        Text("Cargando Informacion...")
                      ],
                    ),
                  );
                  break;
                case ConnectionState.active:
                  // TODO: Handle this case.
                  break;
                case ConnectionState.done:

                  return Container(
                    child: ListView.separated(
                        itemBuilder: (context, int index){
                          String url;
                          if(snapshot.data[index].urlImage!=""){
                            url=snapshot.data[index].urlImage;
                          }
                          else{url="https://graffica.info/wp-content/uploads/2014/02/newsEN_welcome-21.png";}
                      return ListTile(
                        leading: Image.network(url),
                      title: Text(snapshot.data[index].titulo,
                        style: TextStyle(fontSize: 15,color: Colors.black54),),
                        subtitle: Text(snapshot.data[index].fecha,style: TextStyle(fontSize: 15,color: Colors.black),) ,
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetails(
                            title: "Noticia",
                            url: snapshot.data[index].urlNoticias,
                            key: null,
                          ),
                          ),
                          );
                        },
                      );
                    }, separatorBuilder: (context, index)=>
                        Divider(
                      color: Colors.grey,

                    ),
                        itemCount: snapshot.data.length
                    ),
                  );
                  break;
              }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
