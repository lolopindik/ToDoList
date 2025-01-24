import 'dart:convert';
import 'package:bloc_to_do/logic/bloc/CategoryPicker/categorypicker_cubit.dart';
import 'package:bloc_to_do/logic/bloc/DatePicker/datepicker_bloc.dart';
import 'package:bloc_to_do/logic/bloc/TextFieldHandler/text_field_handler_bloc.dart';
import 'package:bloc_to_do/logic/bloc/TimePicker/timepicker_bloc.dart';
import 'package:bloc_to_do/logic/funcs/uuid.dart';
import 'package:bloc_to_do/logic/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

part 'data_collection_event.dart';
part 'date_collection_state.dart';

class DataCollectionBloc
    extends Bloc<DataCollectionEvent, DataCollectionState> {
  final CategorypickerCubit categorypickerCubit;
  final DatepickerBloc datepickerBloc;
  final TextFieldHandlerBloc textFieldHandlerBloc;
  final TimepickerBloc timepickerBloc;

  DataCollectionBloc(this.categorypickerCubit, this.datepickerBloc,
      this.textFieldHandlerBloc, this.timepickerBloc)
      : super(DateCollectionInitial()) {
    on<SaveDataEvent>(_onSaveData);
  }

  Future<void> _onSaveData(
      SaveDataEvent event, Emitter<DataCollectionState> emit) async {
    try {
      final id = ID().generateUuid();

      final category = (categorypickerCubit.state is CategorypickerSelected)
          ? (categorypickerCubit.state as CategorypickerSelected).categoryIndex
          : null;
      final selectedDate = (datepickerBloc.state is DatepickerSelected)
          ? (datepickerBloc.state as DatepickerSelected).selectedDate
          : null;

      final title = textFieldHandlerBloc.titleController.text.trim();
      final notes = textFieldHandlerBloc.notesController.text.trim();

      final selectedTime = (timepickerBloc.state is TimepickerSelected)
          ? (timepickerBloc.state as TimepickerSelected).selectedTime
          : null;

      if (id.isEmpty ||
          category == null ||
          selectedDate == null ||
          title.isEmpty ||
          notes.isEmpty ||
          selectedTime == null) {
        emit(DataCollectionFailure(errorMessage: 'Some fields are empty'));
        return;
      }

      final formattedTime =
          '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';

      final Map<String, dynamic> collectedData = {
        'id': id,
        'title': title,
        'category': category,
        'notes': notes,
        'selectedDate': selectedDate.toIso8601String().split('T')[0],
        'selectedTime': formattedTime,
        'isCompleted': false,
      };

      final String jsonData = json.encode(collectedData);

      final prefs = await SharedPreferences.getInstance();
      final existingData = prefs.getStringList('collectedDataList') ?? [];
      existingData.add(jsonData);
      await prefs.setStringList('collectedDataList', existingData);

      final notificationService = NotificationService();
      final taskId = id.hashCode;

      final tzDateTime = tz.TZDateTime.local(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      await notificationService.scheduleNotification(
        taskId,
        'Напоминание',
        'Пора выполнить задачу: $title',
        tzDateTime,
      );

      emit(DateCollectionSuccess());
    } catch (e) {
      emit(DataCollectionFailure(errorMessage: e.toString()));
    }
  }
}
