import 'package:buzz_tech/logic/funcs/collected_tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AlertDialogService {

  final String tittle = 'Delete task';
  final String question = 'Are you sure you want to delete this task?';
  final String button_1 = 'Cancel';
  final String button_2 = 'Delete';

  Future<void> showDeleteDialog(
      BuildContext context, Map<String, dynamic> task) async {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(tittle),
          content: Text(question),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(button_1),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => CollectedTasks().deleteTask(context, task),
              child: Text(button_2),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(tittle),
          content: Text(question),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(button_1),
            ),
            TextButton(
              onPressed: () => CollectedTasks().deleteTask(context, task),
              child: Text(button_2),
            ),
          ],
        ),
      );
    }
  }
}
