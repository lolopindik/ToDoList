import 'package:bloc_to_do/constants/preferences.dart';
import 'package:bloc_to_do/presentation/pages/home_page.dart';
import 'package:bloc_to_do/presentation/widgets/bottom_button_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ToDoColors.secondaryColor,
        bottomNavigationBar: CustomButton().buildBottombar(
          context,
          'Add new Task',
          () => Navigator.of(context).pushNamed('/add_task'),
        ),
        body: HomePage().buildHomePage(context));
  }
}
