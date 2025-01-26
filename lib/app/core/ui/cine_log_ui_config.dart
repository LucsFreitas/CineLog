import 'package:flutter/material.dart';

class CineLogUiConfig {
  CineLogUiConfig._();

  static get theme => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue[900]!),
        appBarTheme: AppBarTheme(
          color: Colors.blue[900],
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        useMaterial3: true,
      );
}
