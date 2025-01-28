import 'package:buzz_tech/logic/funcs/collected_tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AlertDialogService {
  static void showDeleteDialog(
      BuildContext context, Map<String, dynamic> task) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Удалить задачу'),
          content: const Text('Вы уверены, что хотите удалить эту задачу?'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Отмена'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => CollectedTasks().deleteTask(context, task),
              child: const Text('Удалить'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Удалить задачу'),
          content: const Text('Вы уверены, что хотите удалить эту задачу?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () => CollectedTasks().deleteTask(context, task),
              child: const Text('Удалить'),
            ),
          ],
        ),
      );
    }
  }
}
