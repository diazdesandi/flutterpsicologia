//librerias a importar para el uso de paquetes del protocolo http y el alimnetador de noticias
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';
//creacion de clase para la importacion de la informacion
class GetRSS {
  //Future se utiliza para un calculo retrasado, en este caso lo utilizamos para el llamado hacia la pagina http
  // de la cual traeremos la infromacion, con la cual utilizaremos el Async para realizar una tarea asincrona con la pagina
  static Future<List<Noticias>> gettrss() async {
//en esta seccion usamos el await que esperaria el valor de la tarea async para mostrar 
//la informacion, en este el await solo tiene dos opciones, que el async envie un error o mande la informacion correcta
    var data = await http.get("http://actualidad.rt.com/feeds/all.rss",
    //la cabecera es un metodo de autentificacion Json para la informacion(La cabecera es un valor del mismo)
        headers: {"Content-Type": "application/json"});
        //creacion de un objeto que nos servira para alojar los datos traidos en la variable data, hacia el metodo rssFeed
    var rssFeed = new RssFeed.parse(data.body.toString());
//creacion de lista en el objeto Noticias para cargar en los constructores
    List<Noticias> noticias =
        new List(); //listado de noticias que se devuelven a la interfaz
//ciclo for que nos servira para llenar el objeto que creamos con el nombre rssFeed, en la cual tenemos los campos, titulo,descripcion,fecha,imagenes
// y el enlace de la noticia para abrirla desde la app, al final se coloco un salto de linea 
    for (int i = 0; i < rssFeed.items.length; i++) {
      print("Titulo: " + rssFeed.items[i].title);
      print("Descripcion: " + rssFeed.items[i].description);
      print("Fecha: " + rssFeed.items[i].pubDate);
      print("imagenes Url: " + rssFeed.items[i].enclosure.url);
      print("Enlace a noticia: " + rssFeed.items[i].link);
      print("\n");
//aqui agregamos la informacion que recopilamos anteriormente en la lista de Noticias al objeto rssFeed con los datos que extragimos de la pagina
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
//Clase para la informacion que se mandara a la clase principal para la recoleccion de la informacion
class Noticias {
  String _titulo, _descripcion, _fecha, _urlImage, _urlNoticias;
//Constructores de los objetos para traer la informacion y mostrarla en la interfaz de la aplicacion
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
