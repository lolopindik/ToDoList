// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'text_field_handler_event.dart';
part 'text_field_handler_state.dart';

class TextFieldHandlerBloc extends Bloc<TextFieldHandlerEvent, TextFieldHandlerState> {
  final TextEditingController titleController = TextEditingController();
  //todo add others controllers

  TextFieldHandlerBloc() : super(TextFieldHandlerInitial()) {
    on<TitleEvent>(_onTitleSelected);
  }

  void _onTitleSelected(TitleEvent event, Emitter<TextFieldHandlerState> emit) {
    titleController.text = event.title;
    emit(TitleState(event.title));
    print('Title: ${titleController.text}');
  }

  @override
  Future<void> close() {
    titleController.dispose();
    return super.close();
  }
}
