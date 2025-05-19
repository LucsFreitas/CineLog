import 'package:cine_log/app/models/enums/sort_direction.dart';
import 'package:cine_log/app/models/enums/sort_field.dart';

class SortOption {
  final SortField field;
  final SortDirection direction;

  SortOption({
    required this.field,
    required this.direction,
  });

  factory SortOption.defaultOption() {
    return SortOption(
      field: SortField.createdDate,
      direction: SortDirection.desc,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SortOption &&
          runtimeType == other.runtimeType &&
          field == other.field &&
          direction == other.direction;

  @override
  int get hashCode => field.hashCode ^ direction.hashCode;

  String getNameFieldToQuery() {
    switch (field) {
      case SortField.name:
        return 'coalesce(title,original_title)';
      case SortField.createdDate:
        return 'created_at';
      case SortField.voteAverage:
        return 'vote_average';
      case SortField.duration:
        return 'runtime';
    }
  }
}
