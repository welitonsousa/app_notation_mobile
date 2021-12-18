import 'package:app_notation_mobile/app/controllers/todos/controller_todo_list.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_snack.dart';
import 'package:app_notation_mobile/app/models/model_state.dart';
import 'package:app_notation_mobile/app/models/model_todo.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:flutter/material.dart';

class ControllerTodo extends ChangeNotifier {
  ControllerTodo({required this.todo}) {
    if (todo.id.isNotEmpty) {
      editTodoName.text = todo.title;
    }
  }

  ModelTodo todo;
  ModelState stateTodos = ModelState.stope;

  TextEditingController editTodoName = TextEditingController();
  TextEditingController editTaskName = TextEditingController();

  final formTask = GlobalKey<FormState>();
  final formTodo = GlobalKey<FormState>();

  void addTask() {
    if (formTask.currentState!.validate()) {
      final task = ModelTask(
        id: '${DateTime.now()}',
        title: editTaskName.text,
        checked: false,
      );
      editTaskName.clear();
      todo.tasks.add(task);
      navigator.pop();
      notifyListeners();
    }
  }

  void updateTask(ModelTask task) {
    if (formTask.currentState!.validate()) {
      task = ModelTask(
        id: task.id,
        title: editTaskName.text,
        checked: task.checked,
      );

      for (int i = 0; i < todo.tasks.length; i++) {
        if (todo.tasks[i].id == task.id) {
          todo.tasks[i] = task;
        }
      }

      editTaskName.clear();
      navigator.pop();
      notifyListeners();
    }
  }

  void removeTask(ModelTask task) {
    todo.tasks.removeWhere((element) => element == task);
    notifyListeners();
  }

  void changeTaskValue(ModelTask task) {
    task.checked = !task.checked;
    notifyListeners();
  }

  Future<void> saveTodo() async {
    if (formTodo.currentState!.validate()) {
      try {
        stateTodos = ModelState.loading;
        notifyListeners();
        todo.title = editTodoName.text;
        if (todo.id.isNotEmpty) {
          await ControllerTodoList.instance.updateTodo(todo);
        } else {
          todo.id = '${DateTime.now()}';
          await ControllerTodoList.instance.addTodo(todo);
        }
        await ControllerTodoList.instance.getAllTodos(update: true);
        stateTodos = ModelState.success;
        if (todo.id.isNotEmpty) {
          CustomSnackbar.show(text: "Lista atualizada com sucesso");
        } else {
          CustomSnackbar.show(text: "Lista cadastrada com sucesso");
        }
        navigator.pop();
      } catch (e) {
        stateTodos = ModelState.error;
      }
    }
  }
}
