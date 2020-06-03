import 'dart:convert';
import 'dart:io';
import 'package:flutterpsicologia/pages/youtubevideodata/modelos/channelmodel.dart';
import 'package:flutterpsicologia/pages/youtubevideodata/modelos/videomodel.dart';
import 'package:http/http.dart' as http;
import 'keys.dart';

// Servicio API para obtener videos e información del canal de Youtube
class API_Service {
  API_Service._instantiate();

  static final API_Service instance = API_Service._instantiate();

  final String _baseurl = 'www.googleapis.com';
  String _nextpagetoken = '';

// Representación en interfaz del canal de YouTube
  Future<Channel> fetchChannel({String channelId}) async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      _baseurl,
      '/youtube/v3/channels',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Obtener canal
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      Channel channel = Channel.fromMap(data);

      //Obtener primer paquete de videos de videos publicados
      channel.videos = await fetchVideosFromPlaylist(
        playlistId: channel.uploadPlaylistId,
      );
      return channel;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
  // Metodo asicrono para obtener 8 videos a la vez, con el fin de no saturar la memoria, se usa la API_KEY para esto.
  Future<List<Video>> fetchVideosFromPlaylist({String playlistId}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': _nextpagetoken,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      _baseurl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Obtiene videos de la playlist princ
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      _nextpagetoken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Recibe 8 videos
      List<Video> videos = [];
      videosJson.forEach(
        (json) => videos.add(
          Video.fromMap(json['snippet']),
        ),
      );
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
