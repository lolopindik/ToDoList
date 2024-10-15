import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'date_bloc_event.dart';
part 'date_bloc_state.dart';

class DateBlocBloc extends Bloc<DateBlocEvent, DateBlocState> {
  DateBlocBloc() : super(DateBlocInitial()) {
    on<DateBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
