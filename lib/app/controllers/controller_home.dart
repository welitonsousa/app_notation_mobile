import 'package:flutter/material.dart';

class ControllerHome extends ChangeNotifier {
  int index = 0;
  final pageController = PageController();

  void changePage(int value) async {
    changeIndex(value);
    await pageController.animateToPage(
      index,
      curve: Curves.linear,
      duration: const Duration(milliseconds: 300),
    );
  }

  void changeIndex(int value) {
    index = value;
    notifyListeners();
  }
}
