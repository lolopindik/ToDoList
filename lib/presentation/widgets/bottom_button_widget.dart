import 'package:buzz_tech/constants/preferences.dart';
import 'package:flutter/material.dart';

class CustomButton {
  Widget buildBottombar(
      BuildContext context, String title, VoidCallback onPressedCallback) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
      child: ElevatedButton(
        onPressed: onPressedCallback,
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(Size(
              MediaQuery.of(context).size.width * 1,
              MediaQuery.of(context).size.height * 0.06)),
          backgroundColor: WidgetStateProperty.all(ToDoColors.seedColor),
        ),
        child: Text(
          title,
          style: ToDoTextStyles.white16,
        ),
      ),
    );
  }
}
