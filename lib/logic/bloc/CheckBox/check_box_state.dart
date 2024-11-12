// ignore_for_file: use_super_parameters

part of 'check_box_bloc.dart';

sealed class CheckBoxState {
  final Map<String, bool> checkedItems;

  CheckBoxState(this.checkedItems);
}

class CheckBoxInitial extends CheckBoxState {
  CheckBoxInitial() : super({});
}

class CheckBoxIsChecked extends CheckBoxState {
  CheckBoxIsChecked(Map<String, bool> checkedItems) : super(checkedItems);
}
