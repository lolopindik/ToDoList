// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';
import 'package:bloc_to_do/logic/bloc/CategoryPicker/categorypicker_cubit.dart';
import 'package:bloc_to_do/logic/bloc/DatePicker/datepicker_bloc.dart';
import 'package:bloc_to_do/logic/bloc/TextFieldHandler/text_field_handler_bloc.dart';
import 'package:bloc_to_do/logic/bloc/TimePicker/timepicker_bloc.dart';
import 'package:bloc_to_do/logic/funcs/uuid.dart';
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
      (event.edit)
          ? debugPrint('type is edit: true')
          : debugPrint('type is edit: false');

      (event.task) != null
          ? debugPrint('Map in event: ${event.task}')
          : debugPrint('Map is emt');

      //todo The ability is working, but i will need to add deleting note func
      // ignore: prefer_typing_uninitialized_variables
      // final id;

      // (event.edit) ? id = event.task!['id'] : id = ID().generateUuid();

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

      //* Проверяем заполненность полей
      if (id.isEmpty ||
          category == null ||
          selectedDate == null ||
          title.isEmpty ||
          notes.isEmpty ||
          selectedTime == null) {
        emit(DataCollectionFailure(errorMessage: 'Some fields are empty'));
        return;
      }

      //* Проверка на соответсвие полей
      if (event.edit &&
          category == event.task!['category'] &&
          selectedDate.toIso8601String().split('T')[0] ==
              event.task!['selectedDate'] &&
          title == event.task!['title'] &&
          notes == event.task!['notes'] &&
          selectedTime.format(event.context) == event.task!['selectedTime']) {
        emit(DataCollectionFailure(errorMessage: 'There were no changes'));
        return;
      }

      //* Создаем массив с собранными данными
      final Map<String, dynamic> collectedData = {
        'id': id,
        'title': title,
        'category': category,
        'notes': notes,
        'selectedDate': selectedDate.toIso8601String().split('T')[0],
        'selectedTime': selectedTime.format(event.context),
      };


      //* Преобразуем в json
      final String jsonData = json.encode(collectedData);

      debugPrint('Correct Map: $collectedData');
      debugPrint('Task json: ${jsonData.toString()}');

      //* Сохраняем локально в SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final existingData = prefs.getStringList('collectedDataList') ?? [];
      existingData.add(jsonData);
      await prefs.setStringList('collectedDataList', existingData);

      emit(DateCollectionSuccess());
    } catch (e) {
      emit(DataCollectionFailure(errorMessage: e.toString()));
    }
  }
}
