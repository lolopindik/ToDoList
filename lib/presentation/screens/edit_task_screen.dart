import 'package:flutter/material.dart';
import 'package:buzz_tech/presentation/pages/task_page.dart';
import 'package:buzz_tech/presentation/widgets/task_bloc_consumer_widget.dart';

class EditTask extends StatelessWidget {
  final Map<String, dynamic> task;

  const EditTask({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          TaskConsumer(true, task: task).buildTaskBlocConsumer(context),
      body: TaskPage().buildTaskPage(context, true, task),
    );
  }
}
