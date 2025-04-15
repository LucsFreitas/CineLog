import 'package:cine_log/app/core/consts/texts.dart';
import 'package:cine_log/app/models/movie.dart';
import 'package:flutter/material.dart';

Future<bool?> showAddToLibraryDialog(BuildContext context, Movie movie) {
  return showDialog<bool>(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text('Adicionar filme'),
        content: Text.rich(
          TextSpan(
            text: 'Deseja incluir ',
            style: TextStyle(fontSize: 16),
            children: [
              TextSpan(
                text: movie.title ??
                    movie.originalTitle ??
                    Messages.titleNotAvailable,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' na sua biblioteca?'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('Cancelar', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Alterar'),
          ),
        ],
      );
    },
  );
}
