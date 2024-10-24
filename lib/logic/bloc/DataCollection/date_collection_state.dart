part of 'data_collection_bloc.dart';

abstract class DataCollectionState {}

class DateCollectionInitial extends DataCollectionState {}

class DateCollectionSuccess extends DataCollectionState {}

class DataCollectionFailure extends DataCollectionState {
  final String errorMessage;
  DataCollectionFailure({required this.errorMessage});
}
