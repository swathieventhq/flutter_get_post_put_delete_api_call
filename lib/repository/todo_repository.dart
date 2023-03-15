import 'dart:convert';

import 'package:flutter_get_post_put_delete_api_call/models/Todo.dart';
import 'repository.dart';
import 'package:http/http.dart' as http;

class TodoRepository implements Repository {
  String dataURL = 'https://jsonPlaceholder.typicode.com';

  @override
  Future<String> deletedTodo(Todo todo) async{
    var  url = Uri.parse('$dataURL/todos/${todo.id}');
    var result = 'false';
    await http.delete(url).then((value) {
      print(value.body);
      //temp
      return result = 'true';
    });
    return result;
  }


  //get example
  @override
  Future<List<Todo>> getTodoList() async {
    List<Todo> todoList = [];
    //https://jsonPlaceholder.typicode.com/todos
    var url = Uri.parse('$dataURL/todos');
    var response = await http.get(url);
    print('status code : ${response.statusCode}');
    var body = jsonDecode(response.body); //convert
    // parse
    for (var i = 0; i < body.length; i++) {
      todoList.add(Todo.fromJson(body[i]));
    }
    return todoList;
  }

  // patch example
  // patch --> Modify passed variables only.
  @override
  Future<String> patchCompleted(Todo todo) async {
    var url = Uri.parse('$dataURL/todos/${todo.id}');
    // call back data
    String resData = '';
    // bool? --> String
    await http.patch(
      url,
      body: {'completed': (!todo.completed!).toString()},
      headers: {'Authorization': 'your_token'},
    ).then((response) {
      // homePage --> data
      Map<String, dynamic> result = json.decode(response.body);
      print(result);
      return resData = result['completed'];
    });
    return resData;
  }

  // Modify passed variables only and treat other variables NULL or Default
  @override
  Future<String> putCompleted(Todo todo) async {
    var url = Uri.parse('$dataURL/todos/${todo.id}');
    // call back data
    String resData = '';
    // bool? --> String
    await http.put(
      url,
      body: {'completed': (!todo.completed!).toString()},
      headers: {'Authorization': 'your_token'},
    ).then((response) {
      // homePage --> data
      Map<String, dynamic> result = json.decode(response.body);
      print(result);
      return resData = result['completed'];
    });
    return resData;
  }


  @override
  Future<String> postTodo(Todo todo) async{
   print('${todo.toJson()}');
   var url = Uri.parse('$dataURL/todos/');
   var result = '';
   var response = await http.post(url, body: todo.toJson());
   // Fake Server => get return type != post type
   // change to json method...
   print(response.statusCode);
   print(response.body);
   return 'true';
  }


}
