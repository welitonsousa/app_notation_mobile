import 'package:app_notation_mobile/app/controllers/todos/controller_todo.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_button.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_card.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_field.dart';
import 'package:app_notation_mobile/app/models/model_state.dart';
import 'package:app_notation_mobile/app/models/model_todo.dart';
import 'package:app_notation_mobile/app/pages/page_todo/dialog_task.dart';
import 'package:app_notation_mobile/const/colors.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:app_notation_mobile/utils/validations.dart';
import 'package:flutter/material.dart';

class PageTodoForm extends StatefulWidget {
  final ModelTodo todo;
  const PageTodoForm({Key? key, required this.todo}) : super(key: key);

  @override
  _PageTodoFormState createState() => _PageTodoFormState();
}

class _PageTodoFormState extends State<PageTodoForm> {
  late final ControllerTodo controller;

  @override
  void initState() {
    controller = ControllerTodo(todo: widget.todo);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(title: const Text("Tarefa")),
            body: body,
            bottomNavigationBar: actions,
            floatingActionButton: floating,
          );
        });
  }

  Widget get actions {
    return Row(
      children: [
        const SizedBox(height: 0, width: 10),
        Expanded(
          child: CustomButton(
            label: "Cancelar",
            backgroundColor: AppColors.danger,
            onPressed: navigator.pop,
          ),
        ),
        const SizedBox(height: 100, width: 10),
        Expanded(
          child: CustomButton(
            label: "Salvar",
            loading: controller.stateTodos == ModelState.loading,
            onPressed: controller.saveTodo,
          ),
        ),
        const SizedBox(height: 0, width: 10),
      ],
    );
  }

  Widget get floating {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => DialogTask(
            controller: controller,
          ),
        );
      },
    );
  }

  Widget get body {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Form(
            key: controller.formTodo,
            child: CustomField(
              label: "Nome da lista",
              textInputAction: TextInputAction.done,
              controller: controller.editTodoName,
              validator: (value) => Validations.generic(value: value!),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.todo.tasks.length,
              itemBuilder: (context, index) => todoItem(
                widget.todo.tasks[index],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget todoItem(ModelTask task) {
    return CustomCard(
      child: ListTile(
        title: Text(task.title),
        leading: Checkbox(
          value: task.checked,
          onChanged: (value) => controller.changeTaskValue(task),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => controller.removeTask(task),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => DialogTask(
              controller: controller,
              task: task,
            ),
          );
        },
      ),
    );
  }
}
