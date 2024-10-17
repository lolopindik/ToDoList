import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'datepicker_event.dart';
part 'datepicker_state.dart';

class DatepickerBloc extends Bloc<DatepickerEvent, DatepickerState> {
  final TextEditingController dateController = TextEditingController();

  DatepickerBloc() : super(DatepickerInitial());

  Stream<DatepickerState> mapEventToState(
    DatepickerEvent event,
  ) async* {
    if (event is DateSelectedEvent) {
      dateController.text = "${event.selectedDate.toLocal()}".split(' ')[0];
      yield DatepickerSelected(event.selectedDate);
    }
  }

  @override
  Future<void> close() {
    dateController.dispose();
    return super.close();
  }
}

