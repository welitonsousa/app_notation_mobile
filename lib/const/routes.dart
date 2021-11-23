import 'package:app_notation_mobile/app/models/model_notes.dart';
import 'package:app_notation_mobile/app/pages/page_change_password.dart';
import 'package:app_notation_mobile/app/pages/page_home.dart';
import 'package:app_notation_mobile/app/pages/page_login.dart';
import 'package:app_notation_mobile/app/pages/page_notes/page_notes_form.dart';
import 'package:app_notation_mobile/app/pages/page_registration.dart';
import 'package:app_notation_mobile/app/pages/page_reset_pass/page_reset_pass.dart';
import 'package:app_notation_mobile/app/pages/page_splash.dart';
import 'package:app_notation_mobile/app/pages/page_welcome.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final navigator = navigatorKey.currentState!;

class Routes {
  final Map<String, Widget Function(BuildContext)> routes = {
    NamedRoutes.SPLASH: (context) => PageSplash(),
    NamedRoutes.LOGIN: (context) => PageLogin(),
    NamedRoutes.WELCOME: (context) => PageWelcome(),
    NamedRoutes.REGISTRATION: (context) => PageRegistration(),
    NamedRoutes.HOME: (context) => PageHome(),
    NamedRoutes.CHANGE_PASSWORD: (context) => PageChangePassword(),
    NamedRoutes.RESET_PASSWORD: (context) => PageResetPass(),
    NamedRoutes.NOTE_FORM: (context) {
      final note = ModalRoute.of(context)?.settings.arguments as ModelNotes?;
      return PageNotesForm(note: note);
    }
  };
}

class NamedRoutes {
  static const SPLASH = "/";
  static const LOGIN = "/login";
  static const WELCOME = "/welcome";
  static const HOME = "/home";
  static const NOTE_FORM = "/note/form";
  static const REGISTRATION = "/registration";
  static const CHANGE_PASSWORD = "/change-password";
  static const RESET_PASSWORD = "/reset-password";
}
