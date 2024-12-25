import 'package:bloc_to_do/constants/preferences.dart';
import 'package:bloc_to_do/logic/bloc/TextFieldHandler/text_field_handler_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextfiledHandlerWidget {
  final String? initialTitle;
  final String? initialNotes;
  final String errorMessage = "Error: Incorrect processing";

  TextfiledHandlerWidget({this.initialTitle, this.initialNotes});

  Widget buildTextHandler(BuildContext context, String type) {
    final bloc = context.read<TextFieldHandlerBloc>();

    try {
      if (type == 'title') {
        if (bloc.titleController.text.isEmpty) {
          bloc.titleController.text = initialTitle!;
          //* Added event to update data in the bloc
          bloc.add(TitleEvent(bloc.titleController.text));
        }
      } else if (type == 'notes') {
        if (bloc.notesController.text.isEmpty) {
          bloc.notesController.text = initialNotes!;
          //* Added event to update data in the bloc
          bloc.add(NotesEvent(bloc.notesController.text));
        }
      } else {
        bloc.titleController.text = errorMessage;
        bloc.notesController.text = errorMessage;
      }
    } catch (e) {
      debugPrint('Error: $e');

      bloc.titleController.text = errorMessage;
      bloc.notesController.text = errorMessage;
    }

    return BlocBuilder<TextFieldHandlerBloc, TextFieldHandlerState>(
      builder: (context, state) {
        return type == 'title'
            ? TextField(
                controller: bloc.titleController,
                onChanged: (title) {
                  bloc.add(TitleEvent(title));
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
              )
            : TextFormField(
                controller: bloc.notesController,
                onChanged: (notes) {
                  bloc.add(NotesEvent(notes));
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
