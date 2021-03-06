import 'package:app_notation_mobile/app/controllers/controller_splash.dart';
import 'package:app_notation_mobile/const/images.dart';
import 'package:flutter/material.dart';

class PageSplash extends StatefulWidget {
  const PageSplash({Key? key}) : super(key: key);

  @override
  _PageSplashState createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash> {
  final controller = ControllerSplash();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller.startAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, widget) => _body(),
      ),
    );
  }

  Widget _body() {
    return Center(
      child: SizedBox(
        height: controller.size,
        child: Image.asset(AppImages.LOGO),
      ),
    );
  }
}
