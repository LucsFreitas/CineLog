import 'package:cine_log/app/core/consts/texts.dart';

import 'package:cine_log/app/models/enums/sort_direction.dart';
import 'package:cine_log/app/models/enums/sort_field.dart';
import 'package:cine_log/app/models/sort_option.dart';
import 'package:cine_log/app/modules/home/sort_options_notifier.dart';
import 'package:flutter/material.dart';

class HomeLayoutSettingsModal extends StatefulWidget {
  final SortOptionsNotifier sortNotifier;
  const HomeLayoutSettingsModal({super.key, required this.sortNotifier});

  @override
  State<HomeLayoutSettingsModal> createState() =>
      _HomeLayoutSettingsModalState();
}

class _HomeLayoutSettingsModalState extends State<HomeLayoutSettingsModal> {
  late SortOptionsNotifier sortNotifier;
  SortOption currentState = SortOption.defaultOption();

  @override
  void initState() {
    super.initState();
    sortNotifier = widget.sortNotifier;

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _loadCurrentSortOptions());
  }

  Future<void> _loadCurrentSortOptions() async {
    setState(() {
      currentState = sortNotifier.current;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Messages.sortConfigTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 18),
          SegmentedButton<SortDirection>(
            selected: {currentState.direction},
            multiSelectionEnabled: false,
            segments: [
              ButtonSegment<SortDirection>(
                value: SortDirection.asc,
                label: Text(
                  Messages.ascDirection,
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
              ButtonSegment<SortDirection>(
                value: SortDirection.desc,
                label: Text(
                  Messages.descDirection,
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
            ],
            onSelectionChanged: (newSelection) async {
              await sortNotifier.setDirection(newSelection.first);
              await _loadCurrentSortOptions();
            },
            style: ButtonStyle(
              side: WidgetStateProperty.resolveWith<BorderSide>(
                (states) {
                  return BorderSide(
                    color: Colors.grey[400]!,
                    width: 0.5,
                  );
                },
              ),
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: SortField.values.map((field) {
              final isSelected = currentState.field == field;

              String label = getDisplayText(field);

              return ListTile(
                title: Text(label),
                selected: isSelected,
                selectedTileColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                onTap: () async {
                  if (field == currentState.field) return;

                  await sortNotifier.setField(field);
                  await _loadCurrentSortOptions();
                },
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  String getDisplayText(SortField field) {
    switch (field) {
      case SortField.name:
        return Messages.nameSortOption;
      case SortField.createdDate:
        return Messages.createdAtSortOption;
      case SortField.voteAverage:
        return Messages.voteAverageSortOption;
      case SortField.duration:
        return Messages.durationSortOption;
    }
  }
}
