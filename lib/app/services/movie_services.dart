import 'dart:convert';

import 'package:cine_log/app/models/movie.dart';
import 'package:http/http.dart' as http;

class MovieServices {
  String baseUrl = 'https://api.themoviedb.org/3/search/movie';
  String posterBaseUrl = 'https://image.tmdb.org/t/p/w154';

  final Map<String, String> queryParams = {
    'language': 'pt',
    'include_adult': 'false',
  };

  final Map<String, String> headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNjBjNzUxNzFjZWRkNjMyOTE4ZDcyMGQyMDUxYjEzNiIsIm5iZiI6MTczNzUxMTU3My41NjcwMDAyLCJzdWIiOiI2NzkwNTI5NWEzYzdkNzk0NzJkZmU3YWQiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.EJ7K5UxzBAbclcaZQUYVRndOfOgsodveyiQ06D9AqWs',
    'accept': 'application/json'
  };

  Future<List<Movie>> findByTitle(String title, String page) async {
    var result = await http.get(
        Uri.parse(baseUrl).replace(
          queryParameters: {...queryParams, 'query': title, 'page': page},
        ),
        headers: headers);
    var decoded = jsonDecode(result.body);
    var lista = decoded['results'];
    var movies =
        lista.map<Movie>((movieMap) => Movie.fromMap(movieMap)).toList();
    return movies;
  }

  String getEntirePostUrl(String? posterUrl) {
    if (posterUrl == null) return '';
    return posterBaseUrl + posterUrl;
  }
}
