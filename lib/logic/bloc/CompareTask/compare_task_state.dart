part of 'compare_task_bloc.dart';

abstract class CompareTaskState extends Equatable {
  const CompareTaskState();

  @override
  List<Object> get props => [];
}

class CompareTaskInitial extends CompareTaskState {}

class CompareTaskLoading extends CompareTaskState {}

class CompareTaskSuccess extends CompareTaskState {
  final Map<String, dynamic> task;

  const CompareTaskSuccess(this.task);

  @override
  List<Object> get props => [task];
}

class CompareTaskFailure extends CompareTaskState {
  final String error;

  const CompareTaskFailure(this.error);

  @override
  List<Object> get props => [error];
}
