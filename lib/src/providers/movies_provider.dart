import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'package:movies_app/src/models/movie_model.dart';

class MovieProvider {
  String _apikey = '376e387dc1fdb1381e383ac5dfcd8036';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularsPage = 0;

  List<Movie> _populars = [];

  final _popularsStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;

  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  void disposeStreams() {
    _popularsStreamController?.close();
  }

  Future<List<Movie>> _processResponse(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }

  Future<List<Movie>> getOnMovies() async {
    final url = Uri.https(
      _url,
      '3/movie/now_playing',
      {'api_key': _apikey, 'language': _language},
    );

    return await _processResponse(url);
  }

  Future<List<Movie>> getPopulars() async {
    _popularsPage++;

    final url = Uri.https(
      _url,
      '3/movie/popular',
      {
        'api_key': _apikey,
        'language': _language,
        'page': _popularsPage.toString(),
      },
    );

    final resp = await _processResponse(url);

    _populars.addAll(resp);
    popularsSink(_populars);

    return resp;
  }
}
