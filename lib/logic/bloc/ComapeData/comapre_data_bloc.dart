import 'package:bloc_to_do/logic/funcs/get_json.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'comapre_data_event.dart';
part 'comapre_data_state.dart';

class ComapreDataBloc extends Bloc<ComapreDataEvent, ComapreDataState> {
  //* Обработка класса json из shared preferences
  final GetJson getJson;

  ComapreDataBloc(this.getJson) : super(ComapreDataInitial()) {
    on<FetchDataEvent>(_onFetchData);
  }

  //* Обработка события с FetchData
  Future<void> _onFetchData(
      FetchDataEvent event, Emitter<ComapreDataState> emit) async {
    emit(ComapreDataLoading());
    
    getJson.printCollectedData();
    
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
