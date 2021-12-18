import 'package:app_notation_mobile/app/models/model_todo.dart';
import 'package:app_notation_mobile/const/dio.dart';

class RepositoryTodo {
  Future<void> createTodo(ModelTodo todo) async {
    await dio.post('/todo', data: todo.toJson());
  }

  Future<void> updateTodo(ModelTodo todo) async {
    await dio.put('/todo', data: todo.toJson());
  }

  Future<void> deleteTodo(String id) async {
    await dio.delete('/todo/$id');
  }

  Future<List<ModelTodo>> getAllTodos() async {
    List<ModelTodo> todos = [];
    final response = await dio.get('/todo');
    response.data['todos'].forEach((e) => todos.add(ModelTodo.fromJson(e)));
    return todos;
  }
}
