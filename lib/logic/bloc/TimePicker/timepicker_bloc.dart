// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'timepicker_event.dart';
part 'timepicker_state.dart';

class TimepickerBloc extends Bloc<TimepickerEvent, TimepickerState> {
  final TextEditingController timeController = TextEditingController();

  TimepickerBloc() : super(TimepickerInitial()) {
    on<TimeSelectedEvent>((event, emit) {
      timeController.text = event.formattedTime;
      emit(TimepickerSelected(event.selectedTime));
      print('timeController: ${timeController.text}');
    });
  }

  @override
  Future<void> close() {
    timeController.dispose();
    return super.close();
  }
}