import 'package:bloc_to_do/constants/preferences.dart';
import 'package:bloc_to_do/presentation/pages/details_page.dart';
import 'package:bloc_to_do/presentation/widgets/bottom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_to_do/logic/bloc/CompareTask/compare_task_bloc.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ToDoColors.mainColor,
      bottomNavigationBar: BlocBuilder<CompareTaskBloc, CompareTaskState>(
        builder: (context, state) {
          if (state is CompareTaskSuccess) {
            final task = state.task;
            return CustomButton().buildBottombar(
              context,
              'Edit task',
              () {
                Navigator.of(context).pushNamed('/edit_task', arguments: task);
              },
            );
          }
          return Container();
        },
      ),
      body: DetailsPage().buildDetailsPage(context),
    );
  }
}
