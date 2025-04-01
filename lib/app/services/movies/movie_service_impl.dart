import 'package:cine_log/app/models/movie.dart';
import 'package:cine_log/app/models/responses/movie_response.dart';
import 'package:cine_log/app/repositories/movies/movie_repository.dart';
import 'package:cine_log/app/services/movies/movie_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieServiceImpl extends MovieService {
  String baseUrl = 'https://api.themoviedb.org/3/search/movie';
  String posterBaseUrl = 'https://image.tmdb.org/t/p/w154';
  final MovieRepository _moviesRepository;

  MovieServiceImpl({
    required MovieRepository movieRepository,
  }) : _moviesRepository = movieRepository;

  final Map<String, String> queryParams = {
    'language': 'pt',
    'include_adult': 'false',
  };

  final Map<String, String> headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNjBjNzUxNzFjZWRkNjMyOTE4ZDcyMGQyMDUxYjEzNiIsIm5iZiI6MTczNzUxMTU3My41NjcwMDAyLCJzdWIiOiI2NzkwNTI5NWEzYzdkNzk0NzJkZmU3YWQiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.EJ7K5UxzBAbclcaZQUYVRndOfOgsodveyiQ06D9AqWs',
    'accept': 'application/json'
  };

  @override
  Future<MovieResponse> findByTitle(String title, String page) async {
    var result = await http.get(
        Uri.parse(baseUrl).replace(
          queryParameters: {...queryParams, 'query': title, 'page': page},
        ),
        headers: headers);

    var decoded = jsonDecode(result.body);

    var totalPages = decoded['total_pages'] ?? 1;
    var list = decoded['results'];
    var movies =
        list.map<Movie>((movieMap) => Movie.fromMap(movieMap)).toList();

    return MovieResponse(totalPages: totalPages, results: movies);
  }

  @override
  String getEntirePostUrl(String? posterUrl) {
    if (posterUrl == null) return '';
    return posterBaseUrl + posterUrl;
  }

  @override
  Future<void> save(Movie movie) => _moviesRepository.save(movie);
}
