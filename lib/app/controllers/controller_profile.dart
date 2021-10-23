import 'dart:convert';
import 'package:app_notation_mobile/app/controllers/controller_theme.dart';
import 'package:app_notation_mobile/app/controllers/toggl_controller.dart';
import 'package:app_notation_mobile/app/models/model_user.dart';
import 'package:app_notation_mobile/const/dio.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:app_notation_mobile/main.dart';
import 'package:flutter/material.dart';

class ControllerProfile {
  static final instance = ControllerProfile();

  late ModelUser user;
  final togglController = TogglController();

  final theme = ControllerTheme.instance;
  changeToggl() async {
    await theme.changeTheme();
    togglController.changeValue();
  }

  Future<void> loadUser() async {
    final data = prefs.getString("user") ?? "{}";
    final json = jsonDecode(data);
    user = ModelUser.fromjson(json);
    dio.options.headers = {"Authorization": "Bearer ${user.token}"};
  }

  Future<void> logOut() async {
    await prefs.setString("user", "{}");
    navigator.popUntil(ModalRoute.withName(NamedRoutes.WELLCOME));
    navigator.pushNamed(NamedRoutes.WELLCOME);
  }
}
