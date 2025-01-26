import 'package:cine_log/app/core/database/migrations/migration.dart';

class MigrationV1 implements Migration {
  @override
  void create(batch) {
    batch.execute('''
        CREATE TABLE movies (
          id            integer primary key,
          title         text,
          originalTitle text,
          overview      text,
          posterPath    text,
          dataInclusao  datetime
      );
    ''');
  }

  @override
  void update(batch) {}
}
