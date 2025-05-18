import 'package:cine_log/app/core/consts/texts.dart';
import 'package:cine_log/app/models/movie.dart';
import 'package:flutter/material.dart';

Future<bool?> confirmDialog({
  required BuildContext context,
  required Movie movie,
  required String title,
  required String text_1,
  required String text_2,
  required bool invertButtons,
}) {
  return showDialog<bool>(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text(title),
        content: Text.rich(
          TextSpan(
            text: text_1,
            style: TextStyle(fontSize: 16),
            children: [
              TextSpan(
                text: movie.displayTitle!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: text_2),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(
              Messages.no,
              style: !invertButtons ? TextStyle(color: Colors.red) : null,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(
              Messages.yes,
              style: invertButtons ? TextStyle(color: Colors.red) : null,
            ),
          ),
        ],
      );
    },
  );
}
