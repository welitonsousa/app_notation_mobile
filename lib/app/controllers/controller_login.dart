import 'package:app_notation_mobile/app/repository/repository_login.dart';
import 'package:flutter/material.dart';

import 'controller_teddy.dart';

class ControllerLogin extends ChangeNotifier {
  bool loadig = false;

  final repositorie = RepositoryLogin();
  final teddyController = ControllerTeddy();
  final editEmail = TextEditingController();
  final editPass = TextEditingController();

  Future<void> login() async {
    loadig = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 3));
    loadig = false;
    notifyListeners();
  }
}
