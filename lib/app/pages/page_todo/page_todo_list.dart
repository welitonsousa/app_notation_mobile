import 'package:app_notation_mobile/app/controllers/todos/controller_todo_list.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_card.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_empty.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_field.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_loading.dart';
import 'package:app_notation_mobile/app/models/model_state.dart';
import 'package:app_notation_mobile/app/models/model_todo.dart';
import 'package:app_notation_mobile/app/pages/page_todo/view_modal_delete_todo.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:flutter/material.dart';

class PageTodoList extends StatefulWidget {
  const PageTodoList({Key? key}) : super(key: key);

  @override
  _PageTodoListState createState() => _PageTodoListState();
}

class _PageTodoListState extends State<PageTodoList> {
  final controller = ControllerTodoList.instance;

  @override
  void initState() {
    controller.getAllTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: appBar,
            body: body,
            floatingActionButton: floating,
          );
        });
  }

  Widget get body {
    if (controller.stateList == ModelState.loading) {
      return const CustomCircular();
    } else if (controller.listTodos.isEmpty) {
      return CustomEmpty(action: controller.getAllTodos);
    }
    return RefreshIndicator(
      onRefresh: () async => await controller.getAllTodos(update: true),
      child: ListView.builder(
        padding: const EdgeInsets.all(5),
        itemCount: controller.listTodos.length,
        itemBuilder: (context, index) => todoItem(controller.listTodos[index]),
      ),
    );
  }

  PreferredSizeWidget search() {
    return PreferredSize(
      preferredSize: const Size(double.infinity, 70),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomField(
          placeholder: "Pesquisar",
          textInputAction: TextInputAction.search,
          controller: controller.editSearch,
          onChange: controller.search,
          icon: IconButton(
            icon: const Icon(Icons.close),
            onPressed: controller.clearSearch,
          ),
        ),
      ),
    );
  }

  Widget todoItem(ModelTodo todo) {
    return CustomCard(
      child: ListTile(
        title: Text(todo.title),
        subtitle: Text("Quantidade de tarefas: ${todo.tasks.length}"),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => ViewModalDeleteTodo(todo: todo),
            );
          },
        ),
        onTap: () {
          FocusScope.of(context).unfocus();
          navigator.pushNamed(NamedRoutes.TODO_FORM, arguments: {'todo': todo});
        },
      ),
    );
  }

  PreferredSizeWidget get appBar {
    return AppBar(
      title: const Text("Tarefas"),
      bottom: search(),
    );
  }

  Widget get floating {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        navigator.pushNamed(NamedRoutes.TODO_FORM, arguments: {
          'todo': ModelTodo(id: '', tasks: [], title: '', userId: '')
        });
      },
    );
  }
}
