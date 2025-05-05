import 'package:cine_log/app/core/consts/api_urls.dart';
import 'package:cine_log/app/models/movie.dart';
import 'package:cine_log/app/models/responses/movie_response.dart';
import 'package:cine_log/app/repositories/movies/movie_repository.dart';
import 'package:cine_log/app/services/movies/movie_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieServiceImpl extends MovieService {
  final MovieRepository _moviesRepository;

  MovieServiceImpl({
    required MovieRepository movieRepository,
  }) : _moviesRepository = movieRepository;

  final Map<String, String> queryParams = {
    'language': 'pt-BR',
  };

  final Map<String, String> headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNjBjNzUxNzFjZWRkNjMyOTE4ZDcyMGQyMDUxYjEzNiIsIm5iZiI6MTczNzUxMTU3My41NjcwMDAyLCJzdWIiOiI2NzkwNTI5NWEzYzdkNzk0NzJkZmU3YWQiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.EJ7K5UxzBAbclcaZQUYVRndOfOgsodveyiQ06D9AqWs',
    'accept': 'application/json'
  };

  @override
  Future<MovieResponse> findByTitle(String title, String page) async {
    final url = ApiUrls.searchMovie();
    final result = await http.get(
        Uri.parse(url).replace(
          queryParameters: {...queryParams, 'query': title, 'page': page},
        ),
        headers: headers);

    final decoded = jsonDecode(result.body);

    final totalPages = decoded['total_pages'] ?? 1;
    final list = decoded['results'];
    final movies =
        list.map<Movie>((movieMap) => Movie.fromMap(movieMap)).toList();

    return MovieResponse(totalPages: totalPages, results: movies);
  }

  @override
  Future<void> save(Movie movie) => _moviesRepository.save(movie);

  @override
  Future<void> delete(Movie movie) => _moviesRepository.delete(movie);

  @override
  Future<List<Movie>> findAll(bool watched, String? movieName) async {
    return _moviesRepository.findAll(watched, movieName);
  }

  @override
  Future<Movie> fetchMovieExtrasDetails(Movie movie) async {
    final url = ApiUrls.movieDetails(movie.id);
    final result = await http.get(
        Uri.parse(url).replace(
          queryParameters: {...queryParams},
        ),
        headers: headers);

    final parsed = Movie.fromJson(result.body);
    return movie
      ..homepage = parsed.homepage
      ..homepage = parsed.homepage;
  }
}
