// ignore_for_file: constant_identifier_names

import 'package:app_notation_mobile/app/pages/page_change_password.dart';
import 'package:app_notation_mobile/app/pages/page_home.dart';
import 'package:app_notation_mobile/app/pages/page_login.dart';
import 'package:app_notation_mobile/app/pages/page_notes/page_notes_form.dart';
import 'package:app_notation_mobile/app/pages/page_registration.dart';
import 'package:app_notation_mobile/app/pages/page_reset_pass/page_reset_pass.dart';
import 'package:app_notation_mobile/app/pages/page_splash.dart';
import 'package:app_notation_mobile/app/pages/page_todo/page_todo_form.dart';
import 'package:app_notation_mobile/app/pages/page_welcome.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final navigator = navigatorKey.currentState!;

class Routes {
  static arg(context) {
    return ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
  }

  final Map<String, Widget Function(BuildContext)> routes = {
    NamedRoutes.SPLASH: (context) {
      return const PageSplash();
    },
    NamedRoutes.LOGIN: (context) {
      return const PageLogin();
    },
    NamedRoutes.WELCOME: (context) {
      return const PageWelcome();
    },
    NamedRoutes.REGISTRATION: (context) {
      return const PageRegistration();
    },
    NamedRoutes.HOME: (context) {
      return const PageHome();
    },
    NamedRoutes.CHANGE_PASSWORD: (context) {
      return const PageChangePassword();
    },
    NamedRoutes.RESET_PASSWORD: (context) {
      return const PageResetPass();
    },
    NamedRoutes.TODO_FORM: (context) {
      return PageTodoForm(todo: arg(context)["todo"]);
    },
    NamedRoutes.NOTE_FORM: (context) {
      return PageNotesForm(note: arg(context)?["note"]);
    }
  };
}

class NamedRoutes {
  static const SPLASH = "/";
  static const LOGIN = "/login";
  static const WELCOME = "/welcome";
  static const HOME = "/home";
  static const NOTE_FORM = "/note/form";
  static const TODO_FORM = "/todo/form";
  static const REGISTRATION = "/registration";
  static const CHANGE_PASSWORD = "/change-password";
  static const RESET_PASSWORD = "/reset-password";
}
