import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'datepicker_event.dart';
part 'datepicker_state.dart';

class DatepickerBloc extends Bloc<DatepickerEvent, DatepickerState> {
  final TextEditingController dateController = TextEditingController();

  DatepickerBloc() : super(DatepickerInitial()) {
    on<DateSelectedEvent>(_onDateSelected);
  }

  void _onDateSelected(DateSelectedEvent event, Emitter<DatepickerState> emit) {
    dateController.text = "${event.selectedDate.toLocal()}".split(' ')[0];
    emit(DatepickerSelected(event.selectedDate));
  }

  @override
  Future<void> close() {
    dateController.dispose();
    return super.close();
  }
}
