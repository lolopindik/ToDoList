part of 'datepicker_bloc.dart';

abstract class DatepickerState {
  const DatepickerState();
}

class DatepickerInitial extends DatepickerState {}

class DatepickerSelected extends DatepickerState {
  final DateTime selectedDate;

  const DatepickerSelected(this.selectedDate);
}
