import 'package:cine_log/app/models/movie.dart';
import 'package:cine_log/app/models/responses/movie_response.dart';

abstract class MovieService {
  Future<MovieResponse> findByTitle(String title, String page);
  Future<void> save(Movie movie);
  Future<void> delete(Movie movie);
  Future<List<Movie>> findAll(bool watched, String? movieName);
  Future<Movie> fetchMovieExtrasDetails(Movie movie);
}
