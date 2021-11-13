import 'package:app_notation_mobile/app/controllers/controller_change_pass.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_button.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_card.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_field.dart';
import 'package:app_notation_mobile/utils/validations.dart';
import 'package:flutter/material.dart';

class PageChangePassword extends StatefulWidget {
  @override
  _PageChangePasswordState createState() => _PageChangePasswordState();
}

class _PageChangePasswordState extends State<PageChangePassword> {
  final lastFocus = FocusNode(), focusNewPass = FocusNode();
  final controller = ControllerChangePass();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Alterar senha"), centerTitle: true),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, widget) => _body(),
      ),
    );
  }

  Widget _body() {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        Container(height: 80),
        CustomCard(
          child: Form(
            key: controller.form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomField(
                  label: "Senha atual",
                  controller: controller.editPassword,
                  validator: Validations.password,
                  isPass: true,
                  onEditingComplete: () {
                    changeFocus(context, focusNewPass);
                  },
                ),
                CustomField(
                  label: "Nova senha",
                  controller: controller.editNewPassword,
                  validator: Validations.password,
                  isPass: true,
                  focus: focusNewPass,
                  onEditingComplete: () {
                    changeFocus(context, lastFocus);
                  },
                ),
                CustomField(
                  label: "Confirme a nova senha",
                  isPass: true,
                  focus: lastFocus,
                  controller: controller.editNewConfirmPassword,
                  onEditingComplete: () => unfocus(context),
                  validator: (value) =>
                      Validations.confirmPassword(controller.editNewPassword.text, value),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Desconectar todos os dispositivos"),
                  onTap: controller.changeLogOutAll,
                  leading: Visibility(
                    child: Checkbox(
                      value: controller.logOutAll,
                      onChanged: (value) {
                        controller.changeLogOutAll();
                      },
                    ),
                  ),
                ),
                CustomButton(
                  label: "Salvar",
                  loading: controller.loading,
                  onPressed: () {
                    unfocus(context);
                    controller.changePass();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
