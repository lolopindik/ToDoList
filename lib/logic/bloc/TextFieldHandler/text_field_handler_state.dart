// ignore_for_file: non_constant_identifier_names

part of 'text_field_handler_bloc.dart';

abstract class TextFieldHandlerState {
  const TextFieldHandlerState();
}

class TextFieldHandlerInitial extends TextFieldHandlerState {}

class TitleState extends TextFieldHandlerState {
  String title;

  TitleState(this.title);
}

class NotesState extends TextFieldHandlerState {
  String notes;

  NotesState(this.notes);
}
