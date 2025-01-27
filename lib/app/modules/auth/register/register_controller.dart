import 'package:cine_log/app/exceptions/auth_exception.dart';
import 'package:cine_log/app/services/user/user_service.dart';
import 'package:flutter/material.dart';

class RegisterController extends ChangeNotifier {
  final UserService _userService;
  String? error;
  bool success = false;

  RegisterController({
    required UserService userService,
  }) : _userService = userService;

  Future<void> registerUser(String email, String password) async {
    error = null;
    success = false;

    notifyListeners();

    try {
      final user = await _userService.register(email, password);
      if (user != null) {
        success = true;
      } else {
        error = 'Erro ao registrar usuário';
      }
    } on AuthException catch (e) {
      error = e.message;
    } finally {
      notifyListeners();
    }
  }
}
