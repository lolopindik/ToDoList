import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:buzz_tech/logic/funcs/get_json.dart';

part 'compare_task_event.dart';
part 'compare_task_state.dart';

class CompareTaskBloc extends Bloc<CompareTaskEvent, CompareTaskState> {
  final GetJson getJson;

  CompareTaskBloc(this.getJson) : super(CompareTaskInitial()) {
    on<FetchTaskEvent>(_onFetchTaskById);
  }

  Future<void> _onFetchTaskById(
      FetchTaskEvent event, Emitter<CompareTaskState> emit) async {
    emit(CompareTaskLoading());

    try {
      final tasks = await getJson.getCollectedData();

      final task = tasks.firstWhere(
        (task) => task['id'] == event.taskId,
        orElse: () => {},
      );

      if (task.isNotEmpty) {
        emit(CompareTaskSuccess(task));
      } else {
        emit(CompareTaskFailure('Task with ID ${event.taskId} not found'));
      }
    } catch (e) {
      emit(CompareTaskFailure('Error fetching task: $e'));
    }
  }

  void fetchTaskById(String taskId) {
    add(FetchTaskEvent(taskId));
  }
}
