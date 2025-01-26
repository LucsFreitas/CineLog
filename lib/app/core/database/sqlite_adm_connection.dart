import 'package:cine_log/app/core/database/sqlite_connection_factory.dart';
import 'package:flutter/widgets.dart';

class SqliteAdmConnection with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final conn = SqliteConnectionFactory();

    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        conn.closeConnection();
        break;
    }

    super.didChangeAppLifecycleState(state);
  }
}
