import 'package:flutter/material.dart';
import 'package:bloc_to_do/presentation/pages/task_page.dart';
import 'package:bloc_to_do/presentation/widgets/task_bloc_consumer_widget.dart';

class EditTask extends StatelessWidget {
  final Map task;

  const EditTask({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TaskConsumer().buildTaskBlocConsumer(context),
      body: TaskPage().buildTaskPage(context, true, task),
    );
  }
}
