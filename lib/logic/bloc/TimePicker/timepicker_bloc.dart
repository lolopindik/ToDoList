import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'timepicker_event.dart';
part 'timepicker_state.dart';

class TimepickerBloc extends Bloc<TimepickerEvent, TimepickerState> {
  TimepickerBloc() : super(TimepickerInitial()) {
    on<TimepickerEvent>((event, emit) {});
  }
}
