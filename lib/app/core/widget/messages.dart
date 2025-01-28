import 'package:cine_log/app/core/ui/theme_extensions.dart';
import 'package:flutter/material.dart';

class Messages {
  final BuildContext context;

  Messages._(this.context);

  factory Messages.of(BuildContext context) {
    return Messages._(context);
  }

  void showError(String message) => _showMessage(message, Colors.red);

  void showInfo(String message) => _showMessage(message, context.primaryColor);

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(message),
        // action: SnackBarAction(
        //   label: 'Ok, entendi.',
        //   textColor: Colors.white70,
        //   onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        // ),
      ),
    );
  }
}
