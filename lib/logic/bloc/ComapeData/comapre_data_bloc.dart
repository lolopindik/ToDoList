import 'dart:async';

import 'package:bloc_to_do/logic/bloc/CheckBox/check_box_bloc.dart';
import 'package:bloc_to_do/logic/funcs/get_json.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'comapre_data_event.dart';
part 'comapre_data_state.dart';

class ComapreDataBloc extends Bloc<ComapreDataEvent, ComapreDataState> {
  //* Обработка класса json из shared preferences
  final GetJson getJson;

  final CheckBoxBloc checkBoxBloc;
  late final StreamSubscription checkBoxBlocSubscription;

  ComapreDataBloc(this.getJson, this.checkBoxBloc) : super(ComapreDataInitial()) {
    on<FetchDataEvent>(_onFetchData);
    checkBoxBlocSubscription = checkBoxBloc.stream.listen(
      (checkBoxState){
        if (checkBoxState is CheckBoxIsChecked){
          add(ToggleCheckBox() as ComapreDataEvent);
        }
      }
    );
  }

  //* Обработка события с FetchData
  Future<void> _onFetchData(
      FetchDataEvent event, Emitter<ComapreDataState> emit) async {
    emit(ComapreDataLoading());

    try {
      final tasks = await getJson.getCollectedData();
      emit(ComapreDataLoaded(taskList: tasks));
    } catch (e) {
      emit(ComapreDataFailure(error: e.toString()));
    }
  }

  //* Инициализация загрузки
  void fetchData() {
    add(FetchDataEvent());
  }
}
