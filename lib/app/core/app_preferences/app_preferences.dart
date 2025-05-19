import 'package:cine_log/app/models/enums/sort_direction.dart';
import 'package:cine_log/app/models/enums/sort_field.dart';
import 'package:cine_log/app/models/sort_option.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const _sortFieldKey = 'sort_field';
  static const _sortDirectionKey = 'sort_direction';

  static Future<void> setSortOption(SortOption sortOption) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sortFieldKey, sortOption.field.name);
    await prefs.setString(_sortDirectionKey, sortOption.direction.name);
  }

  static Future<SortOption> getSortOption() async {
    final prefs = await SharedPreferences.getInstance();
    final fieldStr = prefs.getString(_sortFieldKey);
    final dirStr = prefs.getString(_sortDirectionKey);

    final field = SortField.values.firstWhere(
      (e) => e.name == fieldStr,
      orElse: () => SortField.createdDate,
    );

    final direction = SortDirection.values.firstWhere(
      (e) => e.name == dirStr,
      orElse: () => SortDirection.desc,
    );

    return SortOption(field: field, direction: direction);
  }
}
