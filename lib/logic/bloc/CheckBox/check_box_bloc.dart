import 'package:buzz_tech/logic/services/notification_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buzz_tech/logic/bloc/ComapeData/comapre_data_bloc.dart';

part 'check_box_event.dart';
part 'check_box_state.dart';

class CheckBoxBloc extends Bloc<CheckBoxEvent, CheckBoxState> {
  final ComapreDataBloc comapreDataBloc;

  CheckBoxBloc(this.comapreDataBloc) : super(CheckBoxInitial()) {
    on<ToggleCheckBox>(_onToggleCheckBox);
  }

  Future<void> _onToggleCheckBox(
      ToggleCheckBox event, Emitter<CheckBoxState> emit) async {
    try {
      final updatedCheckedItems = Map<String, bool>.from(state.checkedItems);
      bool newStatus = !(state.checkedItems[event.taskId] ?? false);

      updatedCheckedItems[event.taskId] = newStatus;

      final prefs = await SharedPreferences.getInstance();
      final existingData = prefs.getStringList('collectedDataList') ?? [];
      final notificationService = NotificationService();

      List<String> updatedData = existingData.map((taskData) {
        final taskMap = json.decode(taskData);
        if (taskMap['id'] == event.taskId) {
          taskMap['isCompleted'] = newStatus;
          notificationService.cancelNotification(taskMap['id'].hashCode);
        }
        return json.encode(taskMap);
      }).toList();

      await prefs.setStringList('collectedDataList', updatedData);

      comapreDataBloc.fetchData();

      emit(CheckBoxIsChecked(updatedCheckedItems, isCompleted: newStatus));
    } catch (e) {
      emit(CheckBoxError(message: 'Failed to update task: $e'));
    }
  }
}
