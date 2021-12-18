import 'package:app_notation_mobile/app/controllers/controller_notes.dart';
import 'package:app_notation_mobile/app/controllers/todos/controller_todo_list.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_button.dart';
import 'package:app_notation_mobile/app/models/model_todo.dart';
import 'package:app_notation_mobile/const/colors.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:flutter/material.dart';

class ViewModalDeleteTodo extends StatefulWidget {
  final ModelTodo todo;
  const ViewModalDeleteTodo({Key? key, required this.todo}) : super(key: key);

  @override
  _ViewModalDeleteTodoState createState() => _ViewModalDeleteTodoState();
}

class _ViewModalDeleteTodoState extends State<ViewModalDeleteTodo> {
  final controller = ControllerTodoList.instance;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, snapshot) {
          return Container(
            constraints: const BoxConstraints(maxHeight: 500),
            child: Scrollbar(
              isAlwaysShown: true,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      Container(height: 20),
                      _inputs,
                      Container(height: 20),
                      _actions,
                      Container(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget get _inputs {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Icon(Icons.warning_amber_rounded,
              size: 50, color: AppColors.danger),
          Container(height: 20),
          const Text(
            "Você deseja realmente deletar essa lista de tarefas?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget get _actions {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            label: "Cancelar",
            backgroundColor: AppColors.danger,
            onPressed: navigator.pop,
          ),
        ),
        Container(width: 10),
        Expanded(
          child: CustomButton(
              label: "Deletar",
              loading: controller.stateDelete == ModelState.loading,
              onPressed: () async {
                await controller.deleteTodo(widget.todo);
                navigator.pop();
              }),
        )
      ],
    );
  }
}
