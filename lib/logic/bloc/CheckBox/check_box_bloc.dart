import 'package:flutter_bloc/flutter_bloc.dart';

part 'check_box_event.dart';
part 'check_box_state.dart';

class CheckBoxBloc extends Bloc<CheckBoxEvent, CheckBoxState> {
  CheckBoxBloc() : super(CheckBoxInitial()) {
    on<ToggleCheckBox>((event, emit) {
      final updatedCheckedItems = Map<String, bool>.from(state.checkedItems);
      updatedCheckedItems[event.taskId] = !(state.checkedItems[event.taskId] ?? false);
      emit(CheckBoxIsChecked(updatedCheckedItems));
    });
  }
}  