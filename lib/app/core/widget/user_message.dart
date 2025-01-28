import 'package:cine_log/app/core/ui/theme_extensions.dart';
import 'package:flutter/material.dart';

class UserMessage {
  final BuildContext context;

  UserMessage._(this.context);

  factory UserMessage.of(BuildContext context) {
    return UserMessage._(context);
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
