import 'package:app_notation_mobile/app/controllers/controller_home.dart';
import 'package:app_notation_mobile/app/pages/page_notes.dart';
import 'package:app_notation_mobile/app/pages/page_profile.dart';
import 'package:flutter/material.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  final controller = ControllerHome();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text("App Notation"),
            centerTitle: true,
          ),
          body: _body(),
          bottomNavigationBar: _bottomNavigationBar(),
        );
      },
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      onTap: controller.changePage,
      currentIndex: controller.index,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          label: "Notas",
          icon: Icon(Icons.notes),
        ),
        BottomNavigationBarItem(
          label: "Perfil",
          icon: Icon(Icons.person_outline),
        ),
      ],
    );
  }

  Widget _body() {
    return PageView(
      controller: controller.pageController,
      onPageChanged: controller.changeIndex,
      children: [
        PageNotes(),
        PageProfile(),
      ],
    );
  }
}
