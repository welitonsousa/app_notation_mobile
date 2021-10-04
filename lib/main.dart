import 'package:app_notation_mobile/const/routes.dart';
import 'package:app_notation_mobile/env.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    this.getInstangePrefs();
    super.initState();
  }

  Future<void> getInstangePrefs() async {
    prefs = await SharedPreferences.getInstance(); 
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: Env.TITLE,
      routes: routes.routes,
      navigatorKey: navigatorKey,
    );
  }
}
