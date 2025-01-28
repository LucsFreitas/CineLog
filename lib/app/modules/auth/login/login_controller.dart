import 'package:cine_log/app/core/consts/texts.dart';
import 'package:cine_log/app/core/notifier/default_change_notifier.dart';
import 'package:cine_log/app/exceptions/auth_exception.dart';
import 'package:cine_log/app/services/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _userService;

  LoginController({required UserService userService})
      : _userService = userService;

  Future<void> login(String email, String password) async {
    showLoadingAndResetState();
    notifyListeners();

    try {
      final user = await _userService.login(email, password);
      if (user != null) {
        success();
      } else {
        setError(Messages.invalidCredencials);
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
