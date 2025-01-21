import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc_to_do/logic/bloc/ComapeData/comapre_data_bloc.dart';  // Импорт ComapreDataBloc

part 'check_box_event.dart';
part 'check_box_state.dart';

class CheckBoxBloc extends Bloc<CheckBoxEvent, CheckBoxState> {
  final ComapreDataBloc comapreDataBloc; // Добавляем ссылку на ComapreDataBloc

  CheckBoxBloc(this.comapreDataBloc) : super(CheckBoxInitial()) {
    on<ToggleCheckBox>(_onToggleCheckBox);
  }

  Future<void> _onToggleCheckBox(ToggleCheckBox event, Emitter<CheckBoxState> emit) async {
    try {
      // Создаем копию текущих checkedItems
      final updatedCheckedItems = Map<String, bool>.from(state.checkedItems);
      bool newStatus = !(state.checkedItems[event.taskId] ?? false);

      updatedCheckedItems[event.taskId] = newStatus;

      // Обновляем isCompleted в SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final existingData = prefs.getStringList('collectedDataList') ?? [];

      List<String> updatedData = existingData.map((taskData) {
        final taskMap = json.decode(taskData);
        if (taskMap['id'] == event.taskId) {
          taskMap['isCompleted'] = newStatus; // Меняем состояние isCompleted
        }
        return json.encode(taskMap);
      }).toList();

      // Сохраняем обновленные данные в SharedPreferences
      await prefs.setStringList('collectedDataList', updatedData);

      // Обновляем данные в ComapreDataBloc
      comapreDataBloc.fetchData(); // <-- Обновляем список задач в ComapreDataBloc

      // Эмитируем новый CheckBoxState
      emit(CheckBoxIsChecked(updatedCheckedItems, isCompleted: newStatus));
    } catch (e) {
      emit(CheckBoxError(message: 'Failed to update task: $e'));
    }
  }
}
