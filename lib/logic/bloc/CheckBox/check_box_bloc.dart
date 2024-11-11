import 'package:flutter_bloc/flutter_bloc.dart';

part 'check_box_event.dart';
part 'check_box_state.dart';

class CheckBoxBloc extends Bloc<CheckBoxEvent, CheckBoxState> {
  CheckBoxBloc() : super(CheckBoxInitial(false)) {
    on<ToggleCheckBox>((event, emit) {
      emit(CheckBoxIsChecked(!state.isChecked));
    });
  }
}
