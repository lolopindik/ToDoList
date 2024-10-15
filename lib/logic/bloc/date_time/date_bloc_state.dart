part of 'date_bloc_bloc.dart';

abstract class DateBlocState extends Equatable {
  const DateBlocState();
  
  @override
  List<Object> get props => [];
}

class DateBlocInitial extends DateBlocState {}
