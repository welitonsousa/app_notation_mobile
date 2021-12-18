import 'package:app_notation_mobile/app/controllers/controller_reset_pass.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_button.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_field.dart';
import 'package:app_notation_mobile/utils/validations.dart';
import 'package:flutter/material.dart';

class ViewSendEmail extends StatefulWidget {
  final ControllerResetPass controller;
  const ViewSendEmail({Key? key, required this.controller}) : super(key: key);

  @override
  _ViewSendEmailState createState() => _ViewSendEmailState();
}

class _ViewSendEmailState extends State<ViewSendEmail> {
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
            onPressed: widget.controller.sendEmail,
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
            "Enviaremos um código único de verificação da conta através do seu email",
            style: TextStyle(fontSize: 23),
            textAlign: TextAlign.center,
          ),
        ),
        Form(
          key: widget.controller.formEmail,
          child: CustomField(
            label: "Email",
            bgColor: Colors.transparent,
            textInputType: TextInputType.emailAddress,
            enable: !widget.controller.loadingButton,
            controller: widget.controller.editEmail,
            validator: Validations.email,
          ),
        )
      ],
    );
  }
}
