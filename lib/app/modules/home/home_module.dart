import 'package:cine_log/app/core/modules/base_module.dart';
import 'package:cine_log/app/modules/home/home_controller.dart';
import 'package:cine_log/app/modules/home/home_page.dart';
import 'package:cine_log/app/modules/home/settings/settings_page.dart';
import 'package:provider/provider.dart';

class HomeModule extends BaseModule {
  HomeModule()
      : super(
          bindings: [
            ChangeNotifierProvider(
              create: (context) => HomeController(movieService: context.read()),
            ),
          ],
          routers: {
            '/home': (context) => HomePage(),
            '/settings': (context) => SettingsPage(),
          },
        );
}
