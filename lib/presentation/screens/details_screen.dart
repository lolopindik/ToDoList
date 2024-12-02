import 'package:bloc_to_do/constants/preferences.dart';
import 'package:bloc_to_do/presentation/pages/details_page.dart';
import 'package:bloc_to_do/presentation/widgets/bottom_button_widget.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ToDoColors.mainColor,
        bottomNavigationBar: CustomButton().buildBottombar(context, 'Edit task',
            () => Navigator.of(context).pushNamed('/edit_task')),
        body: DetailsPage().buildDetailsPage(context));
  }
}
