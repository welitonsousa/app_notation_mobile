import 'package:app_notation_mobile/app/controllers/controller_profile.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_snack.dart';
import 'package:app_notation_mobile/app/repository/repository_login.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ControllerChangePass extends ChangeNotifier {
  bool loading = false;
  bool logOutAll = false;

  final editPassword = TextEditingController();
  final editNewPassword = TextEditingController();
  final editNewConfirmPassword = TextEditingController();
  final form = GlobalKey<FormState>();
  final repo = RepositoryUser();

  changeLogOutAll() {
    logOutAll = !logOutAll;
    notifyListeners();
  }

  Future<void> changePass() async {
    if (form.currentState?.validate() ?? false) {
      try {
        loading = true;
        notifyListeners();
        await repo.changePassword(
          logOutAll: this.logOutAll,
          newPass: editNewConfirmPassword.text,
          pass: editPassword.text,
        );
        navigator.pop();
        CustomSnakbar.show(text: "Senha atualizada com sucesso");
        if (this.logOutAll) ControllerProfile.instance.logOut();
      } on DioError catch (e) {
        CustomSnakbar.error(e);
      } finally {
        loading = false;
        notifyListeners();
      }
    }
  }
}
