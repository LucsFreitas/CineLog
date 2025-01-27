import 'package:cine_log/app/exceptions/auth_exception.dart';
import 'package:cine_log/app/repositories/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        throw AuthException(message: 'Email já utilizado.');
      }

      throw AuthException(message: e.message ?? 'Erro ao registrar >>usuário');
    }
  }
}
