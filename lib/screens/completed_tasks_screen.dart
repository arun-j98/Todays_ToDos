import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../todo_provider.dart';
import '../widgets/todo_card.dart';
import '../widgets/app_drawer.dart';

class CompletedTasksScreen extends StatelessWidget {
  static const routeName = '/completed-tasks';

  @override
  Widget build(BuildContext context) {
    final completedTasks = Provider.of<TodoProvider>(context).completedTodos;
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
      body: completedTasks.length == 0
          ? Center(
            child: Text(
                'Nothing done today :(',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
          )
          : Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: completedTasks.length,
                itemBuilder: (ctx, index) => TodoCard(
                  completedTasks[index].todo,
                  true,
                ),
              ),
            ),
    );
  }
}
