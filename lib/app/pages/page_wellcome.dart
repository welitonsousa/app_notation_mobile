import 'package:app_notation_mobile/app/custom_widgets/custom_buttom.dart';
import 'package:app_notation_mobile/const/colors.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:flutter/material.dart';

class PageWellcome extends StatelessWidget {
  const PageWellcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          margin: const EdgeInsets.all(10),
          child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(child: Text("App Notation", style: TextStyle(fontSize: 30))),
                Container(height: 20),
                CustomButton(label: "Login", onPressed: () => navigator.pushNamed(NamedRoutes.LOGIN)),
                Container(height: 10),
                Center(child: Text("não possui uma conta?")),
                CustomButton(label: "Cadastre-se", backgroundColor: AppColors.secundary),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
