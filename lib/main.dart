import 'package:app_notation_mobile/app/controllers/controller_theme.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:app_notation_mobile/env.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final routes = Routes();
  final controller = ControllerTheme.instance;

  @override
  void initState() {
    initializeDateFormatting();
    this.getInstancePrefs();
    super.initState();
  }

  Future<void> getInstancePrefs() async {
    prefs = await SharedPreferences.getInstance();
    ControllerTheme.instance.loadTheme();
  }



  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, snapshot) {
        return MaterialApp(
          theme: controller.theme,
          title: Env.TITLE,
          debugShowCheckedModeBanner: Env.DEBUG_MODE,
          routes: routes.routes,
          navigatorKey: navigatorKey,
        );
      }
    );
  }
}
