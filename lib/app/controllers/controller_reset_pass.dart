import 'package:app_notation_mobile/app/custom_widgets/custom_snack.dart';
import 'package:app_notation_mobile/app/repository/repository_reset_pass.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ControllerResetPass extends ChangeNotifier {
  final editEmail = TextEditingController();
  final editCode = TextEditingController();
  final editNewPass = TextEditingController();
  final editConfirmNewPass = TextEditingController();
  final controllerPage = PageController();
  final repo = RepositoryResetPass();

  final formEmail = GlobalKey<FormState>();
  final formCode = GlobalKey<FormState>();
  final formNewPass = GlobalKey<FormState>();

  bool loadingButton = false;

  void nextPage() {
    controllerPage.nextPage(
        curve: Curves.linear, duration: const Duration(milliseconds: 300));
  }

  Future<void> sendEmail() async {
    if (formEmail.currentState?.validate() ?? false) {
      try {
        loadingButton = true;
        notifyListeners();
        await repo.sendEmailCode(email: editEmail.text);
        nextPage();
      } on DioError catch (e) {
        CustomSnackbar.error(e);
      } finally {
        loadingButton = false;
        notifyListeners();
      }
    }
  }

  Future<void> valideCode() async {
    if (formCode.currentState?.validate() ?? false) {
      try {
        loadingButton = true;
        notifyListeners();
        await repo.valideCode(code: editCode.text, email: editEmail.text);
        nextPage();
      } on DioError catch (e) {
        CustomSnackbar.error(e);
      } finally {
        loadingButton = false;
        notifyListeners();
      }
    }
  }

  Future<void> resetPass() async {
    if (formNewPass.currentState?.validate() ?? false) {
      try {
        loadingButton = true;
        notifyListeners();
        await repo.resetPass(
            email: editEmail.text,
            code: editCode.text,
            newPass: editNewPass.text);
        navigator.pop();
        CustomSnackbar.show(text: "Sua senha foi alterada");
      } on DioError catch (e) {
        CustomSnackbar.error(e);
      } finally {
        loadingButton = false;
        notifyListeners();
      }
    }
  }
}
