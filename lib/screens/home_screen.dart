import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/todo_list.dart';
import '../widgets/new_todo.dart';
import '../widgets/welcome_card.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFirstTime = false;

  void _addNewTodo() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewTodo(isEditing: false, todo: '',),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _getVisitingFlag() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    isFirstTime = sharedPreference.getBool('firstTime') ?? true;
    if (isFirstTime) {
      setState(() {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => WelcomeCard()),
        );
      });
      await _setVisitingFlag();
    }
  }

  Future<void> _setVisitingFlag() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setBool('firstTime', false);
  }

  @override
  Widget build(BuildContext context) {
    _getVisitingFlag();
    //_setVisitingFlag();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Today\'s To-do\'s',
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
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: TodoList(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _addNewTodo(),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
