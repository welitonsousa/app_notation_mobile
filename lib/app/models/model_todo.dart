class ModelTodo {
  String id, userId, title;
  List<ModelTask> tasks;
  ModelTodo({
    required this.id,
    required this.title,
    required this.tasks,
    required this.userId,
  });

  factory ModelTodo.fromJson(Map json) {
    List<ModelTask> tasks = [];
    (json['tasks']).forEach((e) => tasks.add(ModelTask.fromJson(e)));
    return ModelTodo(
      id: json['id'],
      title: json['title'],
      userId: json['userId'],
      tasks: tasks,
    );
  }

  toJson() {
    return {
      'id': id,
      'title': title,
      'userId': userId,
      'tasks': tasks.map((e) => e.toJson()).toList(),
    };
  }
}

class ModelTask {
  bool checked;
  String id, title;

  ModelTask({required this.id, required this.title, required this.checked});

  factory ModelTask.fromJson(Map json) {
    return ModelTask(
      id: json['id'],
      title: json['title'],
      checked: json['checked'],
    );
  }

  toJson() {
    return {
      'id': id,
      'title': title,
      'checked': checked,
    };
  }
}
