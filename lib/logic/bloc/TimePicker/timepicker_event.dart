part of 'timepicker_bloc.dart';

abstract class TimepickerEvent {
  const TimepickerEvent();
}

class DateSelectedEvent extends TimepickerEvent {
  final DateTime selectedTime;

  const DateSelectedEvent(this.selectedTime);
}
