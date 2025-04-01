import 'package:cine_log/app/app_widget.dart';
import 'package:cine_log/app/core/auth/cinelog_auth_provider.dart';
import 'package:cine_log/app/core/database/sqlite_connection_factory.dart';
import 'package:cine_log/app/repositories/movies/movie_repository.dart';
import 'package:cine_log/app/repositories/movies/movie_repository_impl.dart';
import 'package:cine_log/app/repositories/user/user_repository.dart';
import 'package:cine_log/app/repositories/user/user_repository_impl.dart';
import 'package:cine_log/app/services/movies/movie_service.dart';
import 'package:cine_log/app/services/movies/movie_service_impl.dart';
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
        Provider<MovieRepository>(
          create: (context) =>
              MovieRepositoryImpl(sqliteConnectionFactory: context.read()),
        ),
        Provider<MovieService>(
          create: (context) =>
              MovieServiceImpl(movieRepository: context.read()),
        ),
        ChangeNotifierProvider(
          create: (context) => CinelogAuthProvider(
            firebaseAuth: context.read(),
            userService: context.read(),
          )..loadListener(),
          lazy: false,
        ),
      ],
      child: AppWidget(),
    );
  }
}
