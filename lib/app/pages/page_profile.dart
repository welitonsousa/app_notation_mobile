import 'package:app_notation_mobile/app/controllers/controller_profile.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_avatar.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_buttom.dart';
import 'package:app_notation_mobile/const/colors.dart';
import 'package:app_notation_mobile/const/images.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class PageProfile extends StatefulWidget {
  const PageProfile({Key? key}) : super(key: key);

  @override
  _PageProfileState createState() => _PageProfileState();
}

class _PageProfileState extends State<PageProfile> {
  final controller = ControllerProfile.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        CustomAvatar(image: controller.user.picture),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Text(
              controller.user.user,
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
        ListTile(
          title: Text("Tema do aplicativo", style: TextStyle(fontSize: 20),),
          leading: Container(
            width: 50,
            height: 50,
            child: GestureDetector(
              onTap: controller.changeToggl,
              child: RiveAnimation.asset(
                AppImages.TOGGLE,
                controllers: controller.togglController.listControllers,
              ),
            ),
          ),
        ),
        CustomButton(
          label: "Alerar senha",
        ),
        CustomButton(
          label: "Sair da conta",
          backgroundColor: AppColors.danger,
          onPressed: controller.logOut,
        )
      ],
    );
  }
}
