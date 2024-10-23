import 'package:bloc_to_do/constants/preferences.dart';
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class SnackbarService {
  void showFailureSnackbar(BuildContext context) {
    const snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Oups!',
        titleTextStyle: ToDoTextStyles.white24,
        message: 'You have not filled in all the data!',
        messageTextStyle: ToDoTextStyles.white16,
        contentType: ContentType.failure,
      ),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSuccesSnackbar(BuildContext context) {
    const snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Yeap',
        titleTextStyle: ToDoTextStyles.white24,
        message: 'Data processed successfully',
        messageTextStyle: ToDoTextStyles.white16,
        contentType: ContentType.success,
      ),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
