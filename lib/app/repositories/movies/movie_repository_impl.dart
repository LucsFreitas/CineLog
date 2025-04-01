import 'package:cine_log/app/core/database/sqlite_connection_factory.dart';
import 'package:cine_log/app/models/movie.dart';
import 'package:cine_log/app/repositories/movies/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  MovieRepositoryImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
  }) : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> save(Movie movie) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    movie.createdAt ??= DateTime.now();
    await conn.insert('movies', movie.toMap());
  }
}
