import 'dart:convert';
import 'package:app_notation_mobile/app/controllers/controller_notes.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_snack.dart';
import 'package:app_notation_mobile/app/models/model_user.dart';
import 'package:app_notation_mobile/app/repository/repository_login.dart';
import 'package:app_notation_mobile/const/colors.dart';
import 'package:app_notation_mobile/const/dio.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:app_notation_mobile/env.dart';
import 'package:app_notation_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ControllerProfile extends ChangeNotifier {
  static final instance = ControllerProfile();
  final repo = RepositoryUser();
  late ModelUser user;

  Future<void> getme() async {
    final _user = await repo.getme();
    user.picture = _user.picture;
    user.user = _user.user;
    notifyListeners();
  }

  Future<void> loadUser() async {
    final data = prefs.getString("user") ?? "{}";
    final json = jsonDecode(data);
    user = ModelUser.fromjson(json);
    dio.options.headers = {"Authorization": "Bearer ${user.token}"};
  }

  Future<void> logOut() async {
    await prefs.setString("user", "{}");
    ControllerNotes.instance = ControllerNotes();
    navigator.popUntil(ModalRoute.withName(NamedRoutes.WELLCOME));
    dio.options = options;
    navigator.pushNamed(NamedRoutes.WELLCOME);
  }

  Future<void> sendEmail() async {
    try {
      final Uri emailLaunchUri = Uri(scheme: 'mailto', path: Env.EMAIL_APP);
      await launch(emailLaunchUri.toString());
    } catch (e) {
      CustomSnakbar.show(text: "Algo deu errado", background: AppColors.danger);
    }
  }
}
