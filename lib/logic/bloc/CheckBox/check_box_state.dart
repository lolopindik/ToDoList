// ignore_for_file: use_super_parameters

part of 'check_box_bloc.dart';

sealed class CheckBoxState {
  final bool isChecked;

  CheckBoxState(this.isChecked);
}

class CheckBoxInitial extends CheckBoxState {
  CheckBoxInitial(bool isChecked) : super(isChecked);
}

class CheckBoxIsChecked extends CheckBoxState {
  CheckBoxIsChecked(bool isChecked) : super(isChecked);
}
