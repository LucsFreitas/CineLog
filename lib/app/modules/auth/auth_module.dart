import 'package:cine_log/app/core/modules/base_module.dart';
import 'package:cine_log/app/modules/auth/login/login_controller.dart';
import 'package:cine_log/app/modules/auth/login/login_page.dart';
import 'package:provider/provider.dart';

class AuthModule extends BaseModule {
  AuthModule()
      : super(
          bindings: [
            ChangeNotifierProvider(
              create: (_) => LoginController(),
            ),
          ],
          routers: {
            '/login': (context) => LoginPage(),
          },
        );
}
