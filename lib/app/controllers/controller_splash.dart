import 'package:app_notation_mobile/app/controllers/controller_profile.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ControllerSplash extends ChangeNotifier {
  double size = 200;
  bool growing = true;
  Ticker ticker = Ticker((_) {});

  Future<void> changePage() async {
    final profile = ControllerProfile.instance;
    await profile.loadUser();
    if (profile.user.token.isEmpty) {
      navigator.pushReplacementNamed(NamedRoutes.WELCOME);
    } else {
      navigator.pushReplacementNamed(NamedRoutes.HOME);
    }
  }

  void startAnimation() {
    ticker = Ticker((now) {
      if (size == 0) {
        changePage();
        ticker.stop();
        ticker.dispose();
      } else if (growing) {
        size += 10;
      } else if (size >= 10) {
        size -= 10;
      }
      if (size > 370) growing = false;

      notifyListeners();
    });
    ticker.start();
  }
}
