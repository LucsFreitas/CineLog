import 'package:cine_log/app/core/notifier/default_change_notifier.dart';
import 'package:cine_log/app/exceptions/auth_exception.dart';
import 'package:cine_log/app/services/user/user_service.dart';

class RegisterController extends DefaultChangeNotifier {
  final UserService _userService;

  RegisterController({
    required UserService userService,
  }) : _userService = userService;

  Future<void> registerUser(String email, String password) async {
    showLoadingAndResetState();
    notifyListeners();

    try {
      final user = await _userService.register(email, password);
      if (user != null) {
        success();
      } else {
        setError('Erro ao registrar usuário');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
