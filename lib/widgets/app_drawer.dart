import 'package:flutter/material.dart';

import '../screens/completed_tasks_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        AppBar(
          title: Text(
            'Hey! ',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        ListTile(
          leading: Icon(
            Icons.cancel,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            'Remaining Tasks',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          title: Text(
            'Completed Tasks',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context)
                .pushReplacementNamed(CompletedTasksScreen.routeName);
          },
        ),
        Divider(),
        /* ListTile(
          leading: Icon(
            Icons.storage,
            color: Colors.grey,
          ),
          title: Text(
            'Archived Data',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Divider(), */
      ],
    ));
  }
}
