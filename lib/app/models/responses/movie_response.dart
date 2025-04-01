import 'package:cine_log/app/models/movie.dart';

class MovieResponse {
  final int totalPages;
  final List<Movie> results;

  MovieResponse({required this.totalPages, required this.results});
}
