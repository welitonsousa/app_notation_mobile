import 'package:app_notation_mobile/const/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ControllerSplash extends ChangeNotifier {
  double size = 200;
  bool smalling = false;
  Ticker ticker = Ticker((_) {});

  void startAnimation() {
    ticker = Ticker((now) {
      if (size == 0) {
        navigator.pushReplacementNamed(NamedRoutes.WELLCOME);
        ticker.stop();
        ticker.dispose();
      } else if (!smalling) {
        size += 10;
      } else if (size >= 10) {
        size -= 10;
      }
      if (size > 370) smalling = true;

      notifyListeners();
    });
    ticker.start();
  }
}
