import 'package:app_notation_mobile/app/controllers/controller_reset_pass.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_button.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_field.dart';
import 'package:app_notation_mobile/utils/validations.dart';
import 'package:flutter/material.dart';

class ViewResetPass extends StatefulWidget {
  final ControllerResetPass controller;
  const ViewResetPass({Key? key, required this.controller}) : super(key: key);

  @override
  _ViewResetPassState createState() => _ViewResetPassState();
}

class _ViewResetPassState extends State<ViewResetPass> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, snapshot) {
        return Scaffold(
          body: body,
          bottomSheet: next,
        );
      },
    );
  }

  Widget get next {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: CustomButton(
            label: "Confirmar",
            loading: widget.controller.loadingButton,
            onPressed: widget.controller.resetPass,
          ),
        ),
      ],
    );
  }

  Widget get body {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Text(
            "Todos os dispositivos conectados a esta conta serão desconectados",
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
        Form(
          key: widget.controller.formNewPass,
          child: Column(
            children: [
              CustomField(
                label: "Nova senha",
                enable: !widget.controller.loadingButton,
                controller: widget.controller.editNewPass,
                isPass: true,
                validator: Validations.password,
              ),
              CustomField(
                label: "Confirme a senha",
                enable: !widget.controller.loadingButton,
                controller: widget.controller.editConfirmNewPass,
                isPass: true,
                validator: (value) => Validations.confirmPassword(
                  widget.controller.editNewPass.text,
                  value,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
