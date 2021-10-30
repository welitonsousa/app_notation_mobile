import 'package:app_notation_mobile/app/pages/page_change_password.dart';
import 'package:app_notation_mobile/app/pages/page_home.dart';
import 'package:app_notation_mobile/app/pages/page_login.dart';
import 'package:app_notation_mobile/app/pages/page_registration.dart';
import 'package:app_notation_mobile/app/pages/page_splash.dart';
import 'package:app_notation_mobile/app/pages/page_wellcome.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final navigator = navigatorKey.currentState!;

class Routes {
  final Map<String, Widget Function(BuildContext)> routes = {
    NamedRoutes.SPLASH: (context) => PageSplash(),
    NamedRoutes.LOGIN: (context) => PageLogin(),
    NamedRoutes.WELLCOME: (context) => PageWellcome(),
    NamedRoutes.REGISTRATION: (context) => PageRegistration(),
    NamedRoutes.HOME: (context) => PageHome(),
    NamedRoutes.CHANGE_PASSWORD: (context) => PageChangePassword(),
  };
}

class NamedRoutes {
  static const SPLASH = "/";
  static const LOGIN = "/login";
  static const WELLCOME = "/wellcome";
  static const HOME = "/home";
  static const REGISTRATION = "/registration";
  static const CHANGE_PASSWORD = "/change-password";
}