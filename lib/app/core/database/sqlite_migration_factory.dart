import 'package:cine_log/app/core/database/migrations/migration.dart';
import 'package:cine_log/app/core/database/migrations/migration_v1.dart';
import 'package:cine_log/app/core/database/migrations/migration_v2.dart';

class SqliteMigrationFactory {
  List<Migration> getCreateMigration() => [
        MigrationV1(),
        MigrationV2(),
      ];

  List<Migration> getUpgradeMigration(int oldVersion) {
    final migrations = <Migration>[];

    if (oldVersion == 1) {
      migrations.add(MigrationV2());
    }

    return migrations;
  }

  List<Migration> getDowngradeMigration(int oldVersion) {
    final migrations = <Migration>[];

    if (oldVersion == 2) {
      migrations.add(MigrationV2());
    }

    return migrations;
  }
}
