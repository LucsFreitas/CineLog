import 'package:cine_log/app/core/database/migrations/migration.dart';

class MigrationV1 implements Migration {
  @override
  void create(batch) {
    batch.execute('''
        CREATE TABLE movies (
          id              integer primary key,
          title           text,
          original_title  text,
          overview        text,
          poster_path     text,
          backdrop_path   text,
          homepage        text,
          vote_average    real,
          vote_count      integer,
          runtime         integer,
          release_date    text,
          created_at      datetime DEFAULT (datetime('now')),
          watched_at      datetime,
          watched         integer
      );
    ''');
  }

  @override
  void update(batch) {}

  @override
  void downgrade(batch) {}
}
