import 'package:app_notation_mobile/app/controllers/controller_login.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_buttom.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_field.dart';
import 'package:app_notation_mobile/const/images.dart';
import 'package:flutter/material.dart';
import 'package:app_notation_mobile/utils/validations.dart';
import 'package:rive/rive.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  _PageLoginState createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  final controller = ControllerLogin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body());
  }

  Widget _body() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      children: [
        Container(
          height: 300,
          child: GestureDetector(
            onTap: controller.teddyController.resetLoop,
            child: RiveAnimation.asset(
              AppImages.TEDDY,
              controllers: controller.teddyController.listControllers,
            ),
          ),
        ),
        form(),
      ],
    );
  }

  Widget form() {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomField(
                label: "Email",
                controller: controller.editEmail,
                onTap: controller.teddyController.email,
                onChange: (value) => controller.teddyController.check(value),
                enable: !controller.loadig,
                validator: (value) => Validations.email(value!),
                onEditingComplete: () {
                  nextFocus(context);
                  controller.teddyController.pass();
                }),
            CustomField(
                label: "Senha",
                validator: (value) => Validations.password(value!),
                enable: !controller.loadig,
                controller: controller.editPass,
                isPass: true,
                onTap: controller.teddyController.pass,
                textInputAction: TextInputAction.done,
                onEditingComplete: () {
                  unfocus(context);
                  controller.teddyController.email();
                }),
            CustomButton(
              label: "Login",
              loading: controller.loadig,
              onPressed: controller.login,
            ),
          ],
        );
      },
    );
  }
}
