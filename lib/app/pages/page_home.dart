import 'package:app_notation_mobile/app/controllers/controller_home.dart';
import 'package:app_notation_mobile/app/controllers/controller_profile.dart';
import 'package:app_notation_mobile/app/pages/page_notes/page_notes_list.dart';
import 'package:app_notation_mobile/app/pages/page_profile.dart';
import 'package:app_notation_mobile/app/pages/page_todo/page_todo_list.dart';
import 'package:flutter/material.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  final controller = ControllerHome();

  @override
  void initState() {
    ControllerProfile.instance.getMe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, snapshot) {
        return Scaffold(
          body: _body(),
          bottomSheet: _bottomNavigationBar(),
        );
      },
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      onTap: controller.changePage,
      currentIndex: controller.index,
      selectedIconTheme: const IconThemeData(size: 30),
      items: const [
        BottomNavigationBarItem(
          label: "Notas\n",
          icon: Icon(Icons.notes),
        ),
        BottomNavigationBarItem(
          label: "Tarefas\n",
          icon: Icon(Icons.table_rows_outlined),
        ),
        BottomNavigationBarItem(
          label: "Perfil\n",
          icon: Icon(Icons.person_outline),
        ),
      ],
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: PageView(
        controller: controller.pageController,
        onPageChanged: (index) {
          controller.changeIndex(index);
        },
        physics: const ClampingScrollPhysics(),
        children: const [
          PageNotes(),
          PageTodoList(),
          PageProfile(),
        ],
      ),
    );
  }
}
