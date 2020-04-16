import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../todo_provider.dart';

class NewTodo extends StatefulWidget {
  final bool isEditing;
  final String todo;
  final String id;

  NewTodo({this.isEditing, this.todo, this.id = ''});

  @override
  _NewTodoState createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final _todoInputController = TextEditingController();

  void _saveTodo() {
    Provider.of<TodoProvider>(context, listen: false)
        .addTodo(_todoInputController.text);
    Navigator.of(context).pop();
  }

  void _setEditingTodo() {
    if (widget.isEditing == true) {
      _todoInputController.text = widget.todo;
    }
  }

  void _editTodo() {
    Provider.of<TodoProvider>(context, listen: false)
        .editTodo(widget.id, _todoInputController.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    _setEditingTodo();
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 8,
          right: 8,
          top: 8,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'To-do',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(5),
                counter: Offstage(),
              ),
              keyboardType: TextInputType.multiline,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              minLines: 1,
              maxLines: 4,
              maxLength: 200,
              controller: _todoInputController,
            ),
            Divider(),
            FlatButton(
              child: Text(
                'Save',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onPressed: () => widget.isEditing ? _editTodo() : _saveTodo(),
            ),
          ],
        ),
      ),
    );
  }
}
