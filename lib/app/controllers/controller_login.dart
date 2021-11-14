import 'dart:convert';

import 'package:app_notation_mobile/app/controllers/controller_profile.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_snack.dart';
import 'package:app_notation_mobile/app/repository/repository_user.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:app_notation_mobile/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'controller_teddy.dart';

class ControllerLogin extends ChangeNotifier {
  bool loading = false;

  final repository = RepositoryUser();
  final teddyController = ControllerTeddy();
  final editEmail = TextEditingController();
  final editPass = TextEditingController();
  final form = GlobalKey<FormState>();

  Future<void> login() async {
    if (form.currentState!.validate()) {
      try {
        loading = true;
        notifyListeners();
        final user = await repository.login(email: editEmail.text, pass: editPass.text);
        await prefs.setString("user", jsonEncode(user.toJson()));
        ControllerProfile.instance.loadUser();
        
        navigator.popUntil(ModalRoute.withName(NamedRoutes.HOME));
        navigator.pushNamed(NamedRoutes.HOME);
      
      } on DioError catch (e) {
        CustomSnackbar.error(e);
      } finally {
        loading = false;
        notifyListeners();
      }
    }
  }
}
