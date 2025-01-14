part of 'data_collection_bloc.dart';

abstract class DataCollectionEvent {}

class SaveDataEvent extends DataCollectionEvent {
  final BuildContext context;
  final bool edit;
  final Map? task;

  SaveDataEvent(this.context, this.edit, {this.task});
}
