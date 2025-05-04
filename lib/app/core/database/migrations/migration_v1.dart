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
          vote_average    real,
          vote_count      integer,
          release_date    text,
          created_at      datetime DEFAULT (datetime('now')),
          watched         integer
      );
    ''');
  }

  @override
  void update(batch) {}
}
