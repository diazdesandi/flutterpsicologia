import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutterpsicologia/paginas/youtubevideodata/modelos/modelocanal.dart';
import 'package:flutterpsicologia/paginas/youtubevideodata/modelos/modelovideo.dart';
import 'package:flutterpsicologia/paginas/youtubevideodata/utilidades/keys.dart';

class ServicioAPI {
  ServicioAPI._instantiate();

  static final ServicioAPI instance = ServicioAPI._instantiate();

  final String _baseurl = 'www.googleapis.com';
  String _nextpagetoken = '';

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

    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      _nextpagetoken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
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
