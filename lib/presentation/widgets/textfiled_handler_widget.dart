import 'package:bloc_to_do/constants/preferences.dart';
import 'package:bloc_to_do/logic/bloc/TextFieldHandler/text_field_handler_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextfiledHandlerWidget {
  Widget buildTitle(BuildContext context) {
    return BlocBuilder<TextFieldHandlerBloc, TextFieldHandlerState>(
      builder: (context, state) {
        return TextField(
          onChanged: (title) {
            context.read<TextFieldHandlerBloc>().add(TitleEvent(title));
          },
          maxLength: 30,
          decoration: const InputDecoration(
            hintText: 'Task Title',
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: ToDoColors.mainColor,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildNotes(BuildContext context) {
    return BlocBuilder<TextFieldHandlerBloc, TextFieldHandlerState>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (notes) {
            context.read<TextFieldHandlerBloc>().add(NotesEvent(notes));
          },
          maxLines: (MediaQuery.of(context).size.height * 0.008).toInt(),
          decoration: const InputDecoration(
            hintText: 'Notes',
            border: OutlineInputBorder(),
          ),
        );
      },
    );
  }
}
