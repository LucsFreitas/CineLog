import 'package:cine_log/app/core/widget/cine_log_logo.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CineLogLogo(),
      ),
    );
  }
}
