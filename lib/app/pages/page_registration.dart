import 'package:app_notation_mobile/app/controllers/controller_registration.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_buttom.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_card.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_field.dart';
import 'package:app_notation_mobile/utils/validations.dart';
import 'package:flutter/material.dart';

class PageRegistration extends StatefulWidget {
  @override
  _PageRegistrationState createState() => _PageRegistrationState();
}

class _PageRegistrationState extends State<PageRegistration> {
  final controller = ControllerRegistration();
  final lastFocus = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastre-se"), centerTitle: true),
      body: _body(),
    );
  }

  Widget _body() {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "App Notatino",
              style: TextStyle(fontFamily: "amatic", fontSize: 60),
            ),
          ),
        ),
        CustomCard(
          child: Form(
            key: controller.form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomField(
                  label: "Nome de usuário",
                  controller: controller.editName,
                  validator: (value) =>
                      Validations.generic(value: value, error: "Nome inválido", min: 3),
                ),
                CustomField(
                  label: "Email",
                  controller: controller.editEmail,
                  validator: Validations.email,
                ),
                CustomField(
                  label: "Senha",
                  controller: controller.editPass,
                  validator: Validations.password,
                  isPass: true,
                  onEditingComplete: () {
                    changeFocus(context, lastFocus);
                  },
                ),
                CustomField(
                  label: "Confirme a senha",
                  isPass: true,
                  focus: lastFocus,
                  controller: controller.editConfirmPass,
                  onEditingComplete: () => unfocus(context),
                  validator: (value) =>
                      Validations.confirmPassword(controller.editPass.text, value),
                ),
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, widget) {
                    return CustomButton(
                      label: "Cadastrar",
                      loading: controller.loading,
                      onPressed: controller.createUser,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
