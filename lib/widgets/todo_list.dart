import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todays_todos/widgets/new_todo.dart';

import '../todo_provider.dart';
import './todo_card.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<TodoProvider>(context, listen: false).fetchAndSetData('remaining_todo'),
      builder: (ctx, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? Center(child: CircularProgressIndicator())
          : Consumer<TodoProvider>(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/notes.png'),
                  Divider(
                    indent: MediaQuery.of(context).size.width / 2 - 60,
                    endIndent: MediaQuery.of(context).size.width / 2 - 60,
                  ),
                  Text(
                    'No task to do!',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ],
              ),
              builder: (ctx, todoProvider, ch) => todoProvider.todos.length <= 0
                  ? ch
                  : ListView.builder(
                      itemCount: todoProvider.todos.length,
                      itemBuilder: (ctx, index) => Dismissible(
                        key: Key(todoProvider.todos[index].id),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            Provider.of<TodoProvider>(context, listen: false)
                                .archiveCompleted(todoProvider.todos[index].id);
                            Provider.of<TodoProvider>(context, listen: false)
                                .deleteTodo(todoProvider.todos[index].id);
                            Scaffold.of(context).hideCurrentSnackBar();
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Task completed! Added to completed tasks list.'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                          //showDialog(context: context, builder: (ctx) => AlertDialog(title: Text('Are you sure you want to delete'),));
                          if (direction == DismissDirection.endToStart) {
                            Provider.of<TodoProvider>(context, listen: false)
                                .deleteTodo(todoProvider.todos[index].id);
                            Scaffold.of(context).hideCurrentSnackBar();
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Deleted to-do!'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          }
                        },
                        background: Container(
                          color: Colors.transparent,
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.all(15),
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 24,
                          ),
                        ),
                        secondaryBackground: Container(
                          color: Colors.transparent,
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.all(15),
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 24,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () => showModalBottomSheet(
                            context: context,
                            builder: (ctx) => NewTodo(
                              isEditing: true,
                              todo: todoProvider.todos[index].todo,
                              id: todoProvider.todos[index].id,
                            ),
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                          ),
                          child:
                              TodoCard(todoProvider.todos[index].todo, false),
                        ),
                      ),
                    ),
            ),
    );
  }
}
