part of 'data_transfer_bloc.dart';

sealed class DataTransferState extends Equatable {
  const DataTransferState();

  @override
  List<Object> get props => [];
}

class DataTransferInitial extends DataTransferState {}

class DartaTransferSuccess extends DataTransferState {
  final List<String> data;

  const DartaTransferSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class DataTransferFailure extends DataTransferState {
  final String error;

  const DataTransferFailure(this.error);

  @override
  List<Object> get props => [error];
}
