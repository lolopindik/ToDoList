part of 'check_box_bloc.dart';

sealed class CheckBoxEvent {}

class ToggleCheckBox extends CheckBoxEvent {
  final String taskId;
  ToggleCheckBox(this.taskId);
}
