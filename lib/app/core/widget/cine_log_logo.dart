import 'package:cine_log/app/core/ui/theme_extensions.dart';
import 'package:flutter/material.dart';

class CineLogLogo extends StatelessWidget {
  const CineLogLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo.png',
          height: 140,
        ),
        Text(
          'CineLog',
          style: context.textTheme.headlineMedium,
        ),
      ],
    );
  }
}
