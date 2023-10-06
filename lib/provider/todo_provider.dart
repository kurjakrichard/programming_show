import 'package:flutter/foundation.dart';
import 'package:programming_show/repository/database_handler.dart';
import '../model/todo.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> todoItem = [];

  Future<void> selectTodos() async {
    var databaseHelper = DatabaseHandler();
    final dataList = await databaseHelper.selectAll('todo');
    todoItem = dataList.map((item) => Todo.fromMap(item)).toList();
    notifyListeners();
  }

  Future insertTodo(Todo todo) async {
    var databaseHelper = DatabaseHandler();
    todoItem.add(todo);
    databaseHelper.insertTodo(todo);
    notifyListeners();
  }
}
