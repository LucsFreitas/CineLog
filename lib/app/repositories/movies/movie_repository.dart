import 'package:cine_log/app/models/movie.dart';

abstract class MovieRepository {
  Future<void> save(Movie movie);
  Future<List<Movie>> findAll(bool watched, String? movieName);
}
