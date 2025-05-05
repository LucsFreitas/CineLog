import 'package:cine_log/app/models/movie.dart';
import 'package:flutter/material.dart';

Future<bool?> showRemoveFromLibraryDialog(BuildContext context, Movie movie) {
  return showDialog<bool>(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text('Remover filme'),
        content: Text.rich(
          TextSpan(
            text: 'Deseja remover ',
            style: TextStyle(fontSize: 16),
            children: [
              TextSpan(
                text: movie.displayTitle!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' da sua biblioteca?'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('Não'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Sim', style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}
