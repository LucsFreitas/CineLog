import 'package:cine_log/add_movie/add_movie_page.dart';
import 'package:cine_log/home/home_page.dart';
import 'package:cine_log/settings/settings_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CineLog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        primarySwatch: Colors.teal,
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
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (_) => HomePage(),
        '/settings': (_) => SettingsPage(),
        '/add_movie': (_) => AddMoviePage(),
      },
    );
  }
}
