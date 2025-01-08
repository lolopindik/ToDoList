import 'package:bloc_to_do/presentation/pages/task_page.dart';
import 'package:bloc_to_do/presentation/widgets/task_bloc_consumer_widget.dart';
import 'package:flutter/material.dart';
import 'package:bloc_to_do/constants/preferences.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ToDoColors.mainColor,
        bottomNavigationBar: TaskConsumer(false).buildTaskBlocConsumer(context),
        body: TaskPage().buildTaskPage(context, false));
  }
}
