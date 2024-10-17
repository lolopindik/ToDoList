part of 'timepicker_bloc.dart';

abstract class TimepickerState {
  const TimepickerState();
}

final class TimepickerInitial extends TimepickerState {}

final class TimepickerSelected extends TimepickerState {
  TimeOfDay selectedTime;

  TimepickerSelected(this.selectedTime);
}
