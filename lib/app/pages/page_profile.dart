import 'package:app_notation_mobile/app/controllers/controller_profile.dart';
import 'package:app_notation_mobile/app/controllers/controller_theme.dart';
import 'package:app_notation_mobile/app/controllers/toggle_controller.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_avatar.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_button.dart';
import 'package:app_notation_mobile/const/colors.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:flutter/material.dart';

class PageProfile extends StatefulWidget {
  const PageProfile({Key? key}) : super(key: key);

  @override
  _PageProfileState createState() => _PageProfileState();
}

class _PageProfileState extends State<PageProfile> {
  final controller = ControllerProfile.instance;

  @override
  void initState() {
    controller.getMe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();

    return Scaffold(
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, widget) => _body,
      ),
    );
  }

  Widget get _body {
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
          title: Text("Tema do aplicativo", style: TextStyle(fontSize: 20)),
          onTap: ControllerTheme.instance.changeTheme,
          leading: Container(
            width: 50,
            height: 50,
            child: CustomToggle(value: !ControllerTheme.instance.isDark),
          ),
        ),
        CustomButton(
          label: "Contate-nos",
          onPressed: controller.sendEmail,
        ),
        CustomButton(
          label: "Alterar senha",
          onPressed: () => navigator.pushNamed(NamedRoutes.CHANGE_PASSWORD),
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
