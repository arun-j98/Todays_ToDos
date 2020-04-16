import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './screens/completed_tasks_screen.dart';
import './todo_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: TodoProvider(),
      child: MaterialApp(
        title: 'TT',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Quicksand',
        ),
        home: HomeScreen(),
        routes: {
          CompletedTasksScreen.routeName: (ctx) => CompletedTasksScreen(),
        },
      ),
    );
  }
}
