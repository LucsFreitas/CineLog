import 'package:flutter/material.dart';

class CineLogNavigator {
  CineLogNavigator._();

  static final navigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState get to => navigatorKey.currentState!;
}
