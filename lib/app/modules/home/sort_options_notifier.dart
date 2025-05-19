import 'package:cine_log/app/core/app_preferences/app_preferences.dart';
import 'package:cine_log/app/models/enums/sort_direction.dart';
import 'package:cine_log/app/models/enums/sort_field.dart';
import 'package:cine_log/app/models/sort_option.dart';
import 'package:flutter/material.dart';

class SortOptionsNotifier extends ChangeNotifier {
  late SortField _currentField;
  late SortDirection _currentDirection;

  SortOptionsNotifier() {
    final defaultOption = SortOption.defaultOption();
    _currentField = defaultOption.field;
    _currentDirection = defaultOption.direction;
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final option = await AppPreferences.getSortOption();
    _currentField = option.field;
    _currentDirection = option.direction;
  }

  SortOption get current => SortOption(
        field: _currentField,
        direction: _currentDirection,
      );

  Future<void> setField(SortField field) async {
    _currentField = field;
    await _saveToPrefs(current);
  }

  Future<void> setDirection(SortDirection direction) async {
    _currentDirection = direction;
    await _saveToPrefs(current);
  }

  Future<void> _saveToPrefs(SortOption option) async {
    await AppPreferences.setSortOption(current);
    notifyListeners();
  }
}
