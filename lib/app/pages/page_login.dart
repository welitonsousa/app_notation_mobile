import 'package:app_notation_mobile/app/controllers/controller_login.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_button.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_card.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_field.dart';
import 'package:app_notation_mobile/const/images.dart';
import 'package:app_notation_mobile/const/routes.dart';
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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
    );
  }

  Widget _body() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      children: [
        SizedBox(
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
    return CustomCard(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, snapshot) {
          return Form(
            key: controller.form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomField(
                    label: "Email",
                    controller: controller.editEmail,
                    onTap: controller.teddyController.email,
                    onChange: (value) =>
                        controller.teddyController.check(value),
                    enable: !controller.loading,
                    textInputType: TextInputType.emailAddress,
                    validator: (value) => Validations.email(value!),
                    onEditingComplete: () {
                      nextFocus(context);
                      controller.teddyController.pass();
                    }),
                CustomField(
                    label: "Senha",
                    validator: (value) => Validations.password(value!),
                    enable: !controller.loading,
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
                  loading: controller.loading,
                  onPressed: () {
                    controller.teddyController.email();
                    controller.login();
                  },
                ),
                TextButton(
                  child: const Text("Esqueci minha senha"),
                  onPressed: () =>
                      navigator.pushNamed(NamedRoutes.RESET_PASSWORD),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
