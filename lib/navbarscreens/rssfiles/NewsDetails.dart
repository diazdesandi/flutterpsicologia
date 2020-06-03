import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// Clase para obtener los detalles las noticias a mostrar
class NewsDetails extends StatefulWidget {
  NewsDetails({Key key, this.title, this.url}) : super(key: key);

  final String title;
  final String url;

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}
// Clase que muestra las noticias.
class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      )),
    );
  }
}
