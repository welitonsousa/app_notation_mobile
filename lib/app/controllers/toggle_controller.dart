import 'package:app_notation_mobile/const/images.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class CustomToggle extends StatelessWidget {
  final active = SimpleAnimation("day_idle", autoplay: true);
  final desative = SimpleAnimation("night_idle", autoplay: true);

  final bool value;
  CustomToggle({Key? key, this.value = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: value,
      child: RiveAnimation.asset(
        AppImages.TOGGLE,
        controllers: [active],
      ),
      replacement: RiveAnimation.asset(
        AppImages.TOGGLE,
        controllers: [desative],
      ),
    );
  }
}
