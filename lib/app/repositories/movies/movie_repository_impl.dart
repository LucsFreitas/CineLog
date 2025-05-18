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

  @override
  Future<void> update(Movie movie) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.update(
      'movies',
      movie.toMap(),
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  @override
  Future<void> delete(Movie movie) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.delete('movies', where: 'id = ?', whereArgs: [movie.id]);
  }

  @override
  Future<Movie?> findById(int id) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.query('movies', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? Movie.fromMap(result[0]) : null;
  }

  @override
  Future<List<Movie>> findAll(bool watched, String? movieName) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery(
        'select * from movies where watched = ${watched ? 1 : 0} order by created_at desc');
    return result.map((movie) => Movie.fromMap(movie)).toList();
  }
}
