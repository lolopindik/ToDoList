// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'datepicker_event.dart';
part 'datepicker_state.dart';

class DatepickerBloc extends Bloc<DatepickerEvent, DatepickerState> {
  final TextEditingController dateController = TextEditingController();

  DatepickerBloc({DateTime? initialDate})
      : super(initialDate != null
            ? DatepickerSelected(initialDate)
            : DatepickerInitial()) {
    if (initialDate != null) {
      dateController.text = _formatDate(initialDate);
    }

    on<DateSelectedEvent>(_onDateSelected);
  }

  void _onDateSelected(DateSelectedEvent event, Emitter<DatepickerState> emit) {
    dateController.text = _formatDate(event.selectedDate);
    emit(DatepickerSelected(event.selectedDate));
    debugPrint('Date selected: ${dateController.text}');
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  @override
  Future<void> close() {
    dateController.dispose();
    return super.close();
  }
}
