import 'package:bloc_to_do/presentation/pages/task_page.dart';
import 'package:bloc_to_do/presentation/widgets/task_bloc_consumer_widget.dart';
import 'package:flutter/material.dart';

class EditTask extends StatelessWidget {
  const EditTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: TaskConsumer().buildTaskBlocConsumer(context),
        /*The task page will also be used for 
        this screen since they have one visual*/
        body: TaskPage().buildTaskPage(context, true));
  }
}
