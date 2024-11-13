part of 'data_transfer_bloc.dart';

class DataTransferEvent extends Equatable {
  final String taskId; // taskId для конкретной задачи

  const DataTransferEvent(this.taskId);

  @override
  List<Object> get props => [taskId];
}
