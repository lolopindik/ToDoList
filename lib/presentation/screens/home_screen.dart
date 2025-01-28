import 'package:buzz_tech/constants/preferences.dart';
import 'package:buzz_tech/presentation/pages/home_page.dart';
import 'package:buzz_tech/presentation/widgets/bottom_button_widget.dart';
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
