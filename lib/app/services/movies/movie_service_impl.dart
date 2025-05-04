import 'package:cine_log/app/core/consts/texts.dart';
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
    final result = await http.get(
        Uri.parse(baseUrl).replace(
          queryParameters: {...queryParams, 'query': title, 'page': page},
        ),
        headers: headers);

    final decoded = jsonDecode(result.body);

    final totalPages = decoded['total_pages'] ?? 1;
    final list = decoded['results'];
    final movies = list
        .map<Movie>((movieMap) => completeMovieInfos(Movie.fromMap(movieMap)))
        .toList();

    return MovieResponse(totalPages: totalPages, results: movies);
  }

  @override
  String getEntirePostUrl(String? posterUrl) {
    if (posterUrl == null) return '';
    return posterBaseUrl + posterUrl;
  }

  @override
  Future<void> save(Movie movie) => _moviesRepository.save(movie);

  @override
  Future<List<Movie>> findAll(bool watched, String? movieName) async {
    final movies = await _moviesRepository.findAll(watched, movieName);
    return movies.map(completeMovieInfos).toList();
  }

  @override
  Movie completeMovieInfos(Movie movie) {
    return movie
      ..posterUrl = getEntirePostUrl(movie.posterPath)
      ..displayTitle =
          movie.title ?? movie.originalTitle ?? Messages.titleNotAvailable;
  }
}
