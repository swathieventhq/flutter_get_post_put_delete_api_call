import 'package:flutter_get_post_put_delete_api_call/models/Todo.dart';
import 'package:flutter_get_post_put_delete_api_call/repository/repository.dart';

class TodoController {
  final Repository repository;

  TodoController({required this.repository});

  //get
  Future<List<Todo>> fetchTodoList() async {
    return repository.getTodoList();
  }

//patch
  Future<String> updatePatchCompleted(Todo todo) async {
    return repository.patchCompleted(todo);
  }

  //put

  Future<String> updatePutCompleted(Todo todo) async {
    return repository.putCompleted(todo);
  }


  // delete
  Future<String> deleteTodo(Todo todo) async {
    return repository.deletedTodo(todo);
  }

  // post

  Future<String> postTodo(Todo todo) async {
    return repository.postTodo(todo);
  }

}
