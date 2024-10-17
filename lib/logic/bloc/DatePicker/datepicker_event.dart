part of 'datepicker_bloc.dart';

abstract class DatepickerEvent {
  const DatepickerEvent();
}

class DateSelectedEvent extends DatepickerEvent {
  final DateTime selectedDate;

  const DateSelectedEvent(this.selectedDate);
}
