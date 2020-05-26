import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class GetRSS {
  static Future<List<Noticias>> gettrss() async {
    var data = await http.get("http://actualidad.rt.com/feeds/all.rss",
        headers: {"Content-Type": "application/json"});
    var rssFeed = new RssFeed.parse(data.body.toString());

    List<Noticias> noticias =
        new List(); //listado de noticias que se devuelven a la interfaz

    for (int i = 0; i < rssFeed.items.length; i++) {
      print("Titulo: " + rssFeed.items[i].title);
      print("Descripcion: " + rssFeed.items[i].description);
      print("Fecha: " + rssFeed.items[i].pubDate);
      print("imagenes Url: " + rssFeed.items[i].enclosure.url);
      print("Enlace a noticia: " + rssFeed.items[i].link);
      print("\n");

      noticias.add(new Noticias(
          rssFeed.items[i].title,
          rssFeed.items[i].description,
          rssFeed.items[i].pubDate,
          rssFeed.items[i].enclosure.url,
          rssFeed.items[i].link));
    }
    return noticias;
  }
}

class Noticias {
  String _titulo, _descripcion, _fecha, _urlImage, _urlNoticias;

  Noticias(this._titulo, this._descripcion, this._fecha, this._urlImage,
      this._urlNoticias);

  get urlNoticias => _urlNoticias;

  set urlNoticias(value) {
    _urlNoticias = value;
  }

  get urlImage => _urlImage;

  set urlImage(value) {
    _urlImage = value;
  }

  get fecha => _fecha;

  set fecha(value) {
    _fecha = value;
  }

  get descripcion => _descripcion;

  set descripcion(value) {
    _descripcion = value;
  }

  String get titulo => _titulo;

  set titulo(String value) {
    _titulo = value;
  }
}
