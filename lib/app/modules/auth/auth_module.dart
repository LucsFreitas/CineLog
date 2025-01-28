import 'package:cine_log/app/core/modules/base_module.dart';
import 'package:cine_log/app/modules/auth/login/login_controller.dart';
import 'package:cine_log/app/modules/auth/login/login_page.dart';
import 'package:cine_log/app/modules/auth/register/register_controller.dart';
import 'package:cine_log/app/modules/auth/register/register_page.dart';
import 'package:provider/provider.dart';

class AuthModule extends BaseModule {
  AuthModule()
      : super(
          bindings: [
            ChangeNotifierProvider(
              create: (context) => LoginController(userService: context.read()),
            ),
            ChangeNotifierProvider(
              create: (context) =>
                  RegisterController(userService: context.read()),
            ),
          ],
          routers: {
            '/login': (context) => LoginPage(),
            '/register': (context) => RegisterPage(),
          },
        );
}
