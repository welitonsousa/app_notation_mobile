import 'dart:async';

import 'package:app_notation_mobile/app/custom_widgets/custom_snack.dart';
import 'package:app_notation_mobile/app/models/model_state.dart';
import 'package:app_notation_mobile/app/models/model_todo.dart';
import 'package:app_notation_mobile/app/repository/repository_todo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ControllerTodoList extends ChangeNotifier {
  static ControllerTodoList instance = ControllerTodoList();

  List<ModelTodo> listTodos = [];
  List<ModelTodo> listTodosOriginal = [];
  ModelState stateList = ModelState.stope;
  ModelState stateDelete = ModelState.stope;
  RepositoryTodo repository = RepositoryTodo();

  final editSearch = TextEditingController();

  void clearSearch() {
    editSearch.clear();
    listTodos = [...listTodosOriginal];
    notifyListeners();
  }

  void search(String value) {
    String search = value.toLowerCase();
    listTodos = listTodosOriginal.where((e) {
      return e.title.toLowerCase().contains(search);
    }).toList();
    notifyListeners();
  }

  Future<void> getAllTodos({bool update = false}) async {
    if (stateList == ModelState.stope || update) {
      try {
        if (!update || stateList == ModelState.error) {
          stateList = ModelState.loading;
        }
        if (!update) {
          stateList = ModelState.loading;
          notifyListeners();
        }
        listTodosOriginal = await repository.getAllTodos();
        listTodos = [...listTodosOriginal];
        stateList = ModelState.success;
      } on DioError catch (e) {
        stateList = ModelState.error;
        CustomSnackbar.error(e);
      } finally {
        Timer.run(() => notifyListeners());
      }
    }
  }

  Future<void> addTodo(ModelTodo todo) async {
    await repository.createTodo(todo);
  }

  Future<void> updateTodo(ModelTodo todo) async {
    await repository.updateTodo(todo);
  }

  Future<void> deleteTodo(ModelTodo todo) async {
    try {
      stateDelete = ModelState.loading;
      notifyListeners();
      await repository.deleteTodo(todo.id);
      listTodos.removeWhere((element) => element.id == todo.id);
      stateDelete = ModelState.success;
      CustomSnackbar.show(text: "Lista deletada com sucesso");
    } on DioError catch (e) {
      stateDelete = ModelState.error;
      CustomSnackbar.error(e);
    } finally {
      notifyListeners();
    }
  }
}
