import 'package:flutter/material.dart';
import 'package:flutter_get_post_put_delete_api_call/controller/todo_controller.dart';
import 'package:flutter_get_post_put_delete_api_call/repository/todo_repository.dart';
import 'package:flutter_get_post_put_delete_api_call/models/Todo.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //dependency injection
    var todoController = TodoController(repository: (TodoRepository()));
    //test
    // todoController.fetchTodoList();
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Rest API')),
        backgroundColor: Colors.orange[100],
      ),
      body: FutureBuilder<List<Todo>>(
          future: todoController.fetchTodoList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('error'),
              );
            }
            return buildSafeArea(snapshot, todoController);
          },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
     // make a post call
          // temp data
          Todo todo = Todo(userId: 3, title: 'sample post', completed: false);
          todoController.postTodo(todo);
        },
      ),
    );
  }

  SafeArea buildSafeArea(AsyncSnapshot<List<Todo>> snapshot, TodoController todoController) {
    return SafeArea(
            child: ListView.separated(
              itemBuilder: (context, index) {
                var todo = snapshot.data?[index];
                return Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('${todo?.id}'),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text('${todo?.title}'),
                      ),
                      Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: (){
                                  // make controller method
                                  todoController
                                      .updatePatchCompleted(todo!)
                                      .then((value) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                    duration: const Duration(milliseconds: 500),
                                              content: Text('$value'),
                                            ),
                                        );
                                  });
                                },
                                child: buildContainer(
                                  'patch',
                                  Color(0xFFFFE0B2),
                                ),
                              ),
                   SizedBox(width: 5,),
                              //make put call
                              InkWell(
                                onTap: (){
                                   todoController.updatePutCompleted(todo!);
                                },
                                child: buildContainer(
                                  'put',
                                  Color(0xFFE1BEE7),
                                ),
                              ),
                              SizedBox(width: 5,),
                              //make delete call
                              InkWell(
                                onTap: (){
                                  todoController
                                      .deleteTodo(todo!)
                                      .then((value){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(milliseconds: 500),
                                        content: Text('$value'),
                                      ),
                                    );
                                  }
                                  );
                                },
                                child: buildContainer(
                                  'delete',
                                  Color(0xFFFFCDD2),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  thickness: 0.5,
                  height: 0.5,
                );
              },
              itemCount: snapshot.data?.length ?? 0,
            ),
          );
  }

  Container buildContainer(String title, color) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(child: Text(title)),
    );
  }
}
