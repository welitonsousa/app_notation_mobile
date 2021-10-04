import 'package:app_notation_mobile/app/pages/page_login.dart';
import 'package:app_notation_mobile/app/pages/page_splash.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final navigator = navigatorKey.currentState!;

class Routes {
  final Map<String, Widget Function(BuildContext)> routes = {
    NamedRoutes.SPLASH: (context) => PageSplash(),
    NamedRoutes.LOGIN: (context) => PageLogin(),
  };
}

class NamedRoutes {
  static const SPLASH = "/";
  static const LOGIN = "/login";
}