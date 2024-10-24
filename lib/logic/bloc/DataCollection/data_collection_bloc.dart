import 'dart:convert';

import 'package:bloc_to_do/logic/bloc/CategoryPicker/categorypicker_cubit.dart';
import 'package:bloc_to_do/logic/bloc/DatePicker/datepicker_bloc.dart';
import 'package:bloc_to_do/logic/bloc/TextFieldHandler/text_field_handler_bloc.dart';
import 'package:bloc_to_do/logic/bloc/TimePicker/timepicker_bloc.dart';
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
      //* собираем данные с блоков
      final category = (categorypickerCubit.state is CategorypickerSelected)
          ? (categorypickerCubit.state as CategorypickerSelected).categoryIndex
          : null;

      final selectedDate = (datepickerBloc.state is DatepickerSelected)
          ? (datepickerBloc.state as DatepickerSelected).selectedDate
          : null;

      final title = textFieldHandlerBloc.titleController.text;
      final notes = textFieldHandlerBloc.notesController.text;

      final selectedTime = (timepickerBloc.state is TimepickerSelected)
          ? (timepickerBloc.state as TimepickerSelected).selectedTime
          : null;

      //* создаем массив с собранными данными
      final Map<String, dynamic> collectedData = {
        'title': title,
        'category': category,
        'notes': notes,
        'selectedDate': selectedDate?.toIso8601String(),
        'selectedTime': selectedTime?.format(event.context),
      };

      if (category == null ||
          selectedDate == null ||
          title == '' ||
          notes == '' ||
          selectedTime == null) {
        emit(DataCollectionFailure(errorMessage: 'Fields are empt'));
        return;
      }

      //* преобразуем в json
      final String jsonData = json.encode(collectedData);

      debugPrint('Task json: ${jsonData.toString()}');

      //* сохраняем локально в SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('collectedData', jsonData);

      emit(DateCollectionSuccess());
    } catch (e) {
      emit(DataCollectionFailure(errorMessage: e.toString()));
    }
  }
}
