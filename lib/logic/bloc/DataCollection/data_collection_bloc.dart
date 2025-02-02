import 'dart:convert';
import 'package:buzz_tech/logic/bloc/CategoryPicker/categorypicker_cubit.dart';
import 'package:buzz_tech/logic/bloc/DatePicker/datepicker_bloc.dart';
import 'package:buzz_tech/logic/bloc/TextFieldHandler/text_field_handler_bloc.dart';
import 'package:buzz_tech/logic/bloc/TimePicker/timepicker_bloc.dart';
import 'package:buzz_tech/logic/funcs/uuid.dart';
import 'package:buzz_tech/logic/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      debugPrint(event.edit ? 'Edit mode: true' : 'Edit mode: false');
      debugPrint(
          event.task != null ? 'Event task: ${event.task}' : 'Task is empty');

      final id = event.edit ? event.task!['id'] : ID().generateUuid();
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
        emit(DataCollectionFailure(
            errorMessage:
                'Some fields are empty. Check Title, Notes, Date, and Time.'));
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

      final prefs = await SharedPreferences.getInstance();
      final existingData = prefs.getStringList('collectedDataList') ?? [];

      try {
        for (final task in existingData) {
          json.decode(task);
        }
      } catch (e) {
        debugPrint('Invalid data in SharedPreferences: $e');
        await prefs.remove('collectedDataList');
      }

      if (event.edit) {
        final updatedData = existingData.map((task) {
          final taskMap = json.decode(task);
          return taskMap['id'] == id ? json.encode(collectedData) : task;
        }).toList();
        await prefs.setStringList('collectedDataList', updatedData);
      } else {
        existingData.add(json.encode(collectedData));
        await prefs.setStringList('collectedDataList', existingData);
      }

      final notificationService = NotificationService();
      final taskId = id.hashCode;
      final scheduledDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      if (event.edit) {
        await notificationService.cancelNotification(taskId);
      }
      await notificationService.scheduleNotification(
        taskId,
        title,
        notes,
        scheduledDateTime,
      );

      emit(DateCollectionSuccess());
    } catch (e) {
      emit(DataCollectionFailure(errorMessage: e.toString()));
    }
  }
}
