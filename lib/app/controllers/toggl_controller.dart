import 'package:app_notation_mobile/const/images.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';


class CustomToggl extends StatelessWidget {
  final active = SimpleAnimation("day_idle", autoplay: true);
  final desactive = SimpleAnimation("night_idle", autoplay: true);
  
  final bool value;
  CustomToggl({this.value = true});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: this.value,
      child: RiveAnimation.asset(
        AppImages.TOGGLE,
        controllers: [active],
      ),
      replacement: Container(
        child: RiveAnimation.asset(
          AppImages.TOGGLE,
          controllers: [desactive],
        ),
      ),
    );
  }
}
