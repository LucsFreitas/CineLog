import 'package:cine_log/app/models/movie.dart';

abstract class MovieRepository {
  Future<void> save(Movie movie);
  Future<void> update(Movie movie);
  Future<void> delete(Movie movie);
  Future<Movie?> findById(int id);
  Future<List<Movie>> findAll(bool watched, String? movieName);
}
