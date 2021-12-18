import 'package:app_notation_mobile/app/controllers/todos/controller_todo.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_button.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_field.dart';
import 'package:app_notation_mobile/app/models/model_todo.dart';
import 'package:app_notation_mobile/const/colors.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:app_notation_mobile/utils/validations.dart';
import 'package:flutter/material.dart';

class DialogTask extends StatefulWidget {
  final ControllerTodo controller;
  final ModelTask? task;
  const DialogTask({Key? key, required this.controller, this.task})
      : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<DialogTask> {
  @override
  initState() {
    if (widget.task != null) {
      widget.controller.editTaskName.text = widget.task!.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Form(
              key: widget.controller.formTask,
              child: CustomField(
                label: "Tarefa",
                validator: (value) => Validations.generic(value: value),
                controller: widget.controller.editTaskName,
              ),
            ),
            Row(children: [
              Expanded(
                child: CustomButton(
                  label: "Calcelar",
                  onPressed: navigator.pop,
                  backgroundColor: AppColors.danger,
                ),
              ),
              Container(width: 10),
              Expanded(
                child: CustomButton(
                  label: "Salvar",
                  onPressed: () {
                    if (widget.task == null) {
                      widget.controller.addTask();
                    } else {
                      widget.controller.updateTask(widget.task!);
                    }
                  },
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
