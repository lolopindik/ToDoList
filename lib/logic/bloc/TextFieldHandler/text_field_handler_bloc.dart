// ignore_for_file: avoid_print

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
    titleController.text = event.title;
    emit(TitleState(event.title));
    print('Title: ${titleController.text.trim()}');
  }

  void _onNotesSelected(NotesEvent event, Emitter<TextFieldHandlerState> emit) {
    notesController.text = event.notes;
    emit(NotesState(event.notes));
    print('Notes: ${notesController.text.trim()}');
  }

  @override
  Future<void> close() {
    titleController.dispose();
    notesController.dispose();
    return super.close();
  }
}
