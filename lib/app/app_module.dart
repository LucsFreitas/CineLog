import 'package:cine_log/app/app_widget.dart';
import 'package:cine_log/app/core/database/sqlite_connection_factory.dart';
import 'package:cine_log/app/repositories/user/user_repository.dart';
import 'package:cine_log/app/repositories/user/user_repository_impl.dart';
import 'package:cine_log/app/services/user/user_service.dart';
import 'package:cine_log/app/services/user/user_service_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => SqliteConnectionFactory(),
          lazy: false,
        ),
        Provider(
          create: (_) => FirebaseAuth.instance,
        ),
        Provider<UserRepository>(
          create: (context) => UserRepositoryImpl(firebaseAuth: context.read()),
        ),
        Provider<UserService>(
          create: (context) => UserServiceImpl(userRepository: context.read()),
        ),
      ],
      child: AppWidget(),
    );
  }
}
