// import 'package:bloc_to_do/constants/preferences.dart';
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class SnackbarService {
  void showSnackbar(
      BuildContext context, String title, String message, bool success) {
    var snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        // titleTextStyle: ToDoTextStyles.white24,
        message: message,
        // messageTextStyle: ToDoTextStyles.white16,
        contentType: (success) ? ContentType.success : ContentType.failure,
      ),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
