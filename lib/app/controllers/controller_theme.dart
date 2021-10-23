import 'package:app_notation_mobile/main.dart';
import 'package:flutter/material.dart';

class ControllerTheme extends ChangeNotifier {
  static final instance = ControllerTheme();

  ThemeData theme = ThemeData.light().copyWith(platform: TargetPlatform.iOS);
  bool isDark = false;

  void loadTheme() {
    isDark = prefs.getBool("isDark") ?? false;
    theme = getTheme();
    notifyListeners();
  }

  ThemeData getTheme() {
    if (isDark) return ThemeData.dark().copyWith(platform: TargetPlatform.iOS);
    return ThemeData.light().copyWith(platform: TargetPlatform.iOS);
  }

  Future<void> changeTheme() async {
    isDark = !isDark;
    theme = getTheme();
    await prefs.setBool("isDark", isDark);
    notifyListeners();
  }
}
