import 'package:app_notation_mobile/app/controllers/controller_reset_pass.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_button.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_field.dart';
import 'package:app_notation_mobile/utils/validations.dart';
import 'package:flutter/material.dart';

class ViewValideCode extends StatefulWidget {
  final ControllerResetPass controller;
  const ViewValideCode({Key? key, required this.controller}) : super(key: key);

  @override
  _ViewValideCodeState createState() => _ViewValideCodeState();
}

class _ViewValideCodeState extends State<ViewValideCode> {
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
            label: "Próximo",
            loading: widget.controller.loadingButton,
            onPressed: widget.controller.valideCode,
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
          child: Text.rich(
            TextSpan(
                text: "Enviamos um código de verificação para o seu email",
                children: [
                  TextSpan(
                      text: "\n\nVerifique também a caixa de Spam",
                      style: TextStyle(fontSize: 14))
                ]),
            style: TextStyle(fontSize: 23),
            textAlign: TextAlign.center,
          ),
        ),
        Form(
          key: widget.controller.formCode,
          child: CustomField(
            label: "Código",
            enable: !widget.controller.loadingButton,
            controller: widget.controller.editCode,
            textCapitalization: TextCapitalization.characters,
            max: 5,
            validator: (value) => Validations.generic(
              min: 5,
              value: value,
              error: "Código inválido",
            ),
          ),
        )
      ],
    );
  }
}
