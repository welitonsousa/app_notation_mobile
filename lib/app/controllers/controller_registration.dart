import 'package:app_notation_mobile/app/custom_widgets/custom_snack.dart';
import 'package:app_notation_mobile/app/repository/repository_user.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ControllerRegistration extends ChangeNotifier {
  final editName = TextEditingController();
  final editEmail = TextEditingController();
  final editPass = TextEditingController();
  final editConfirmPass = TextEditingController();
  final form = GlobalKey<FormState>();
  final repository = RepositoryUser();

  bool loading = false;

  Future<void> createUser() async {
    if (form.currentState!.validate()) {
      try {
        loading = true;
        notifyListeners();
        await repository.registration(
          email: editEmail.text,
          pass: editPass.text,
          name: editName.text,
        );
        loading = false;
        notifyListeners();
        CustomSnakbar.show(text: "Usuário criado com sucesso");
        await Future.delayed(Duration(milliseconds: 1000));
        navigator.popAndPushNamed(NamedRoutes.LOGIN);
      } on DioError catch (e) {
        loading = false;
        notifyListeners();
        CustomSnakbar.error(e);
      }
    }
  }
}
