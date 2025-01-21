part of 'check_box_bloc.dart';

sealed class CheckBoxState {
  final Map<String, bool> checkedItems;

  CheckBoxState(this.checkedItems);
}

class CheckBoxInitial extends CheckBoxState {
  CheckBoxInitial() : super({});
}

class CheckBoxIsChecked extends CheckBoxState {
  final bool isCompleted;

  CheckBoxIsChecked(super.checkedItems, {required this.isCompleted});
}

class CheckBoxError extends CheckBoxState {
  final String message;
  CheckBoxError({required this.message}) : super({});
}
