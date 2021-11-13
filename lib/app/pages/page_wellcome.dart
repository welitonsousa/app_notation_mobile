import 'package:app_notation_mobile/app/custom_widgets/custom_button.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_card.dart';
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: Text("App Notation", style: TextStyle(fontSize: 50, fontFamily: "amatic"))),
                ),
                CustomButton(
                    label: "Login", onPressed: () => navigator.pushNamed(NamedRoutes.LOGIN)),
                Container(height: 10),
                Center(child: Text("não possui uma conta?")),
                CustomButton(
                  label: "Cadastre-se",
                  backgroundColor: AppColors.secundary,
                  onPressed: () => navigator.pushNamed(NamedRoutes.REGISTRATION),
                ),
                Container(height: 20),

              ],
            ),
          ),
        ),
      ],
    );
  }
}
