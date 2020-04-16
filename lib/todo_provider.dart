import 'package:flutter/foundation.dart';

import './models/todo.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [
    // Todo(
    //   id: DateTime.now().toString(),
    //   todo: 'DATA MINING \n1.Project\n2.Assignment',
    // ),
    // Todo(
    //   id: DateTime.now().toString(),
    //   todo: 'ADBMS \n1.Project\n2.PPT of research paper.',
    // ),
    // Todo(
    //   id: DateTime.now().toString(),
    //   todo: 'TECHNICAL COMMUNICATION \n1.Assignment on CRUs.',
    // ),
  ];

  List<Todo> _completedTodos = [];

  List<Todo> get todos {
    return [..._todos];
  }

  List<Todo> get completedTodos {
    return [..._completedTodos];
  }

  void addTodo(String todo) {
    final newTodo = new Todo(id: DateTime.now().toString(), todo: todo);
    _todos.add(newTodo);
    notifyListeners();
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  void archiveCompleted(String id) {
    int todoIndex = _todos.indexWhere((todo) => todo.id == id);
    Todo copiedTodo = new Todo(
      id: _todos[todoIndex].id,
      todo: _todos[todoIndex].todo,
    );
    _todos.removeWhere((todo) => todo.id == id);
    _completedTodos.add(copiedTodo);
    notifyListeners();
  }

  void editTodo(String id, String newTodo) {
    var editedTodo = Todo(id: id, todo: newTodo);
    _todos.removeWhere((todo) => todo.id == id);
    _todos.add(editedTodo);
    notifyListeners();
  }
}
