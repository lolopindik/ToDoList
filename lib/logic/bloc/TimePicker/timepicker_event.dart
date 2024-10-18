part of 'timepicker_bloc.dart';

abstract class TimepickerEvent {
  const TimepickerEvent();
}

class TimeSelectedEvent extends TimepickerEvent {
  final TimeOfDay selectedTime;
  final String formattedTime;

  TimeSelectedEvent(this.selectedTime, this.formattedTime);
}

