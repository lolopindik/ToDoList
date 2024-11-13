import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'data_transfer_event.dart';
part 'data_transfer_state.dart';

class DataTransferBloc extends Bloc<DataTransferEvent, DataTransferState> {
  DataTransferBloc() : super(DataTransferInitial()) {
    on<DataTransferEvent>((event, emit) async {
      final taskId = event.taskId;

      try {
        final data = await getDataByTaskId(taskId);
        emit(DartaTransferSuccess(data));
      } catch (e) {
        emit(const DataTransferFailure("Failed to load data"));
      }
    });
  }

  Future<List<String>> getDataByTaskId(String taskId) async {
    return ['Task details for $taskId'];
  }
}
