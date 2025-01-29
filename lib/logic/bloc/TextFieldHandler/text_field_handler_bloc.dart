import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'text_field_handler_event.dart';
part 'text_field_handler_state.dart';

class TextFieldHandlerBloc
    extends Bloc<TextFieldHandlerEvent, TextFieldHandlerState> {
  final TextEditingController titleController;
  final TextEditingController notesController;

  TextFieldHandlerBloc({String initialTitle = '', String initialNotes = ''})
      : titleController = TextEditingController(text: initialTitle),
        notesController = TextEditingController(text: initialNotes),
        super(TextFieldHandlerInitial()) {
    on<TitleEvent>(_onTitleSelected);
    on<NotesEvent>(_onNotesSelected);
  }

  void _onTitleSelected(TitleEvent event, Emitter<TextFieldHandlerState> emit) {
    final cursorPosition = titleController.selection;
    titleController.text = event.title;
    titleController.selection = cursorPosition;
    emit(TitleState(event.title));
  }

  void _onNotesSelected(NotesEvent event, Emitter<TextFieldHandlerState> emit) {
    final cursorPosition = notesController.selection;
    notesController.text = event.notes;
    notesController.selection = cursorPosition;
    emit(NotesState(event.notes));
  }

  @override
  Future<void> close() {
    titleController.dispose();
    notesController.dispose();
    return super.close();
  }
}

class TextfiledHandlerWidget {
  final String? initialTitle;
  final String? initialNotes;
  final String errorMessage = "Error: Incorrect processing";

  TextfiledHandlerWidget({this.initialTitle, this.initialNotes});

  Widget buildTextHandler(BuildContext context, String type) {
    final bloc = context.read<TextFieldHandlerBloc>();

    try {
      if (type == 'title' && bloc.titleController.text.isEmpty) {
        bloc.add(TitleEvent(initialTitle ?? ''));
      } else if (type == 'notes' && bloc.notesController.text.isEmpty) {
        bloc.add(NotesEvent(initialNotes ?? ''));
      }
    } catch (e) {
      debugPrint('Error: $e');
      bloc.add(TitleEvent(errorMessage));
      bloc.add(NotesEvent(errorMessage));
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
                  border: OutlineInputBorder(),
                ),
              )
            : TextFormField(
                controller: bloc.notesController,
                onChanged: (notes) {
                  bloc.add(NotesEvent(notes));
                },
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Notes',
                  border: OutlineInputBorder(),
                ),
              );
      },
    );
  }
}
