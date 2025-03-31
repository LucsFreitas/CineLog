import 'package:cine_log/app/core/database/sqlite_adm_connection.dart';
import 'package:cine_log/app/core/navigator/cine_log_navigator.dart';
import 'package:cine_log/app/core/ui/cine_log_ui_config.dart';
import 'package:cine_log/app/modules/auth/auth_module.dart';
import 'package:cine_log/app/modules/home/home_module.dart';
import 'package:cine_log/app/modules/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

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
    return GlobalLoaderOverlay(
      child: MaterialApp(
        navigatorKey: CineLogNavigator.navigatorKey,
        title: 'CineLog',
        theme: CineLogUiConfig.theme,
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
        routes: {
          ...HomeModule().routers,
          ...AuthModule().routers,
        },
      ),
    );
  }
}
