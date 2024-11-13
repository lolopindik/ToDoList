part of 'compare_task_bloc.dart';

abstract class CompareTaskEvent extends Equatable {
  const CompareTaskEvent();

  @override
  List<Object> get props => [];
}

class FetchTaskEvent extends CompareTaskEvent {
  final String taskId;

  const FetchTaskEvent(this.taskId);

  @override
  List<Object> get props => [taskId];
}
