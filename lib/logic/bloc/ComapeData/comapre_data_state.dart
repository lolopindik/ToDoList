part of 'comapre_data_bloc.dart';

abstract class ComapreDataState {}

class ComapreDataInitial extends ComapreDataState {}

class ComapreDataLoading extends ComapreDataState {}

class ComapreDataLoaded extends ComapreDataState {
  final List<Map<String, dynamic>> taskList;
  final List<Map<String, dynamic>> activeTasks;
  final List<Map<String, dynamic>> completedTasks;

  ComapreDataLoaded({
    required this.taskList,
    required this.activeTasks,
    required this.completedTasks,
  });
}

class ComapreDataFailure extends ComapreDataState {
  final String error;
  ComapreDataFailure({required this.error});
}
