import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final String todo;
  final bool isCompleted;

  TodoCard(this.todo, this.isCompleted);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16, left: 15, right: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: isCompleted
            ? Border.all(color: Colors.green, width: 2.0)
            : Border(
                bottom: BorderSide.none,
                top: BorderSide.none,
                left: BorderSide.none,
                right: BorderSide.none,
              ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.grey[200], blurRadius: 25.0)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
                      child: Text(
              todo,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              
            ),
          ),
          isCompleted
              ? Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              : Text(''),
        ],
      ),
    );
  }
}
