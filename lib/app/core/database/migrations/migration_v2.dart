import 'package:cine_log/app/core/database/migrations/migration.dart';

class MigrationV2 implements Migration {
  @override
  void create(batch) {
    batch.execute('''
        ALTER TABLE movies ADD COLUMN genres TEXT;
    ''');
  }

  @override
  void update(batch) {
    batch.execute('''
        ALTER TABLE movies ADD COLUMN genres TEXT;
    ''');
  }

  @override
  void downgrade(batch) {
    batch.execute('''
        ALTER TABLE movies DROP COLUMN genres;
    ''');
  }
}
