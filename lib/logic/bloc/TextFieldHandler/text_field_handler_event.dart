// ignore_for_file: non_constant_identifier_names

part of 'text_field_handler_bloc.dart';

abstract class TextFieldHandlerEvent{
  const TextFieldHandlerEvent();
}

class TitleEvent extends TextFieldHandlerEvent{
  String title;

  TitleEvent(this.title);
}