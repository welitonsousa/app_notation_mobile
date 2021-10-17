import 'package:app_notation_mobile/app/custom_widgets/custom_snack.dart';
import 'package:app_notation_mobile/app/repository/repository_login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'controller_teddy.dart';

class ControllerLogin extends ChangeNotifier {
  bool loadig = false;

  final repositorie = RepositoryUser();
  final teddyController = ControllerTeddy();
  final editEmail = TextEditingController();
  final editPass = TextEditingController();
  final form = GlobalKey<FormState>();

  Future<void> login() async {
    if (form.currentState!.validate()) {
      try {
        loadig = true;
        notifyListeners();
        await repositorie.login(email: editEmail.text, pass: editPass.text);
      } on DioError catch (e) {
        CustomSnakbar.error(e);
      } finally {
        loadig = false;
        notifyListeners();
      }
    }
  }
}
