part of 'comapre_data_bloc.dart';

abstract class ComapreDataState {}

class ComapreDataInitial extends ComapreDataState {}

class ComapreDataLoading extends ComapreDataState {}

class ComapreDataLoaded extends ComapreDataState {
  final List<Map<String, dynamic>> taskList;
  ComapreDataLoaded({required this.taskList});
}

class ComapreDataFailure extends ComapreDataState {
  final String error;
  ComapreDataFailure({required this.error});
}
