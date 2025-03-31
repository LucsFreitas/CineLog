import 'package:cine_log/app/core/consts/texts.dart';
import 'package:cine_log/app/exceptions/auth_exception.dart';
import 'package:cine_log/app/repositories/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);

      if (e.code == 'email-already-in-use') {
        throw AuthException(message: Messages.emailAlreadyInUseError);
      }

      throw AuthException(message: e.message ?? Messages.registerError);
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on PlatformException catch (e) {
      throw AuthException(message: e.message ?? Messages.loginError);
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'invalid-credential') {
        throw AuthException(message: Messages.invalidCredencials);
      }

      throw AuthException(message: e.message ?? Messages.loginError);
    }
  }

  // FIXME: Caso utilize login via google, verificar como fica a mudança de senha
  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on PlatformException catch (e) {
      throw AuthException(message: e.message ?? Messages.loginError);
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);

      if (e.code == 'email-already-in-use') {
        throw AuthException(message: Messages.emailAlreadyInUseError);
      }
      if (e.code == 'invalid-email') {
        throw AuthException(message: Messages.emailInvalidFormat);
      }

      throw AuthException(message: e.message ?? Messages.forgotPasswordError);
    }
  }

  @override
  Future<User?> googleLogin() async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn(); //abre a tela de login
      if (googleUser != null) {
        // final loginMethods = _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);
        // throw AuthException(message: 'Teste google user diferente de null');
        final googleAuth = await googleUser.authentication;
        final firebaseCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        var userCredential =
            await _firebaseAuth.signInWithCredential(firebaseCredential);
        return userCredential.user;
      }
      return null;
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);

      if (e.code == 'account-exists-with-different-credential') {
        throw AuthException(message: Messages.userAlreadyExists);
      }

      throw AuthException(message: e.message ?? Messages.googleLoginError);
    }
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> updateDisplayName(String name) async {
    final user = _firebaseAuth.currentUser;

    if (user != null) {
      await user.updateDisplayName(name);
      user.reload();
    }
  }
}
