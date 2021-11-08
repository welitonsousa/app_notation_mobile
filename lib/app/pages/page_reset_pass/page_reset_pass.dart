import 'package:app_notation_mobile/app/controllers/controller_reset_pass.dart';
import 'package:app_notation_mobile/app/pages/page_reset_pass/view_resete_pass.dart';
import 'package:app_notation_mobile/app/pages/page_reset_pass/view_sent_email.dart';
import 'package:app_notation_mobile/app/pages/page_reset_pass/view_valide_code.dart';
import 'package:flutter/material.dart';

class PageResetPass extends StatefulWidget {
  const PageResetPass({Key? key}) : super(key: key);

  @override
  _PageResetPassState createState() => _PageResetPassState();
}

class _PageResetPassState extends State<PageResetPass> {
  final controller = ControllerResetPass();
  
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Redefina sua senha")),
      body: body,
    );
  }

  Widget get body {
    return PageView(
      controller: controller.controllerPage,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ViewSendEmail(controller: this.controller),
        ViewValideCode(controller: this.controller),
        ViewResetePass(controller: this.controller),
      ],
    );
  }
}
