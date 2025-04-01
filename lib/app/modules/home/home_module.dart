import 'package:cine_log/app/core/modules/base_module.dart';
import 'package:cine_log/app/modules/home/home_page.dart';
import 'package:cine_log/app/modules/home/settings/settings_page.dart';

class HomeModule extends BaseModule {
  HomeModule()
      : super(
          routers: {
            '/home': (context) => HomePage(),
            '/settings': (context) => SettingsPage(),
          },
        );
}
