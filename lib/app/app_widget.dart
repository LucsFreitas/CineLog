import 'package:cine_log/app/core/database/sqlite_adm_connection.dart';
import 'package:cine_log/app/modules/auth/auth_module.dart';
import 'package:cine_log/app/pages/add_movie/add_movie_page.dart';
import 'package:cine_log/app/pages/home/home_page.dart';
import 'package:cine_log/app/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final sqliteAdmConnection = SqliteAdmConnection();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(sqliteAdmConnection);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(sqliteAdmConnection);
    super.dispose();
  }

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
      initialRoute: '/login',
      home: HomePage(),
      routes: {
        '/settings': (_) => SettingsPage(),
        '/add_movie': (_) => AddMoviePage(),
        ...AuthModule().routers,
      },
    );
  }
}
