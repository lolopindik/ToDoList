import 'package:bloc_to_do/logic/funcs/get_json.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'comapre_data_event.dart';
part 'comapre_data_state.dart';

class ComapreDataBloc extends Bloc<ComapreDataEvent, ComapreDataState> {
  final GetJson getJson;

  ComapreDataBloc(this.getJson) : super(ComapreDataInitial()) {
    on<FetchDataEvent>(_onFetchData);
  }

  Future<void> _onFetchData(
      FetchDataEvent event, Emitter<ComapreDataState> emit) async {
    emit(ComapreDataLoading());

    try {
      final tasks = await getJson.getCollectedData();

      // Фильтрация задач на основе состояния isCompleted
      final activeTasks =
          tasks.where((task) => task['isCompleted'] == false).toList();
      final completedTasks =
          tasks.where((task) => task['isCompleted'] == true).toList();

      emit(ComapreDataLoaded(
        taskList: tasks,
        activeTasks: activeTasks,
        completedTasks: completedTasks,
      ));
    } catch (e) {
      emit(ComapreDataFailure(error: e.toString()));
    }
  }

  void fetchData() {
    add(FetchDataEvent());
  }
}
