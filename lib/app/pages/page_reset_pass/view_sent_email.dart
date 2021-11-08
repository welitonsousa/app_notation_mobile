import 'package:app_notation_mobile/app/controllers/controller_reset_pass.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_buttom.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_field.dart';
import 'package:app_notation_mobile/utils/validations.dart';
import 'package:flutter/material.dart';

class ViewSendEmail extends StatefulWidget {
  final ControllerResetPass controller;
  const ViewSendEmail({required this.controller});

  @override
  _ViewSendEmailState createState() => _ViewSendEmailState();
}

class _ViewSendEmailState extends State<ViewSendEmail> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: this.widget.controller,
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
            loading: this.widget.controller.loadingButton,
            onPressed: this.widget.controller.sendEmail,
          ),
        ),
      ],
    );
  }

  Widget get body {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Text(
            "Enviaremos um código unico de verificação da conta atravez do seu email",
            style: TextStyle(fontSize: 23),
            textAlign: TextAlign.center,
          ),
        ),
        Form(
          key: this.widget.controller.formEmail,
          child: CustomField(
            label: "Email",
            bgColor: Colors.transparent,
            textInputType: TextInputType.emailAddress,
            enable: !this.widget.controller.loadingButton,
            controller: this.widget.controller.editEmail,
            validator: Validations.email,
          ),
        )
      ],
    );
  }
}
