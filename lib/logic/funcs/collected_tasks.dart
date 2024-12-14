import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CollectedTasks {
  Future<void> deleteTask(
      BuildContext context, Map<String, dynamic> task) async {
    Navigator.pop(context);
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> tasks = prefs.getStringList('collectedDataList') ?? [];
      tasks.removeWhere((t) => t.contains('"id":"${task['id']}"'));
      await prefs.setStringList('collectedDataList', tasks);
      if (context.mounted) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Не удалось удалить задачу')),
        );
      }
    }
  }
}
