import 'package:cine_log/app/core/navigator/cine_log_navigator.dart';
import 'package:cine_log/app/services/user/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CinelogAuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final UserService _userService;

  CinelogAuthProvider({
    required FirebaseAuth firebaseAuth,
    required UserService userService,
  })  : _firebaseAuth = firebaseAuth,
        _userService = userService;

  Future<void> logout() => _userService.logout();

  User? get user => _firebaseAuth.currentUser;

  void loadListener() {
    _firebaseAuth.userChanges().listen((_) => notifyListeners());
    _firebaseAuth.idTokenChanges().listen((user) {
      if (user != null) {
        CineLogNavigator.to.pushNamedAndRemoveUntil('/home', (route) => false);
      } else {
        CineLogNavigator.to.pushNamedAndRemoveUntil('/login', (route) => false);
      }
    });
  }
}
