import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../todo_provider.dart';
import '../widgets/todo_card.dart';
import '../widgets/app_drawer.dart';

class CompletedTasksScreen extends StatelessWidget {
  static const routeName = '/completed-tasks';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tasks completed today',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: AppDrawer(),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: Provider.of<TodoProvider>(context)
            .fetchAndSetData('completed_todo'),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<TodoProvider>(
                    child: Center(
                      child: Text(
                        'Nothing done today :(',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    builder: (ctx, todoProvider, ch) =>
                        todoProvider.completedTodos.length == 0
                            ? ch
                            : Container(
                                height: MediaQuery.of(context).size.height,
                                child: ListView.builder(
                                  itemCount: todoProvider.completedTodos.length,
                                  itemBuilder: (ctx, index) => TodoCard(
                                    todoProvider.completedTodos[index].todo,
                                    true,
                                  ),
                                ),
                              ),
                  ),
      ),
    );
  }
}
