import 'package:flutter_bloc/flutter_bloc.dart';
part 'categorypicker_state.dart';

class CategorypickerCubit extends Cubit<CategorypickerState> {
  CategorypickerCubit() : super(CategorypickerInitial());
  void categoryPickEvent() => emit(CategorypickerSelected(1));
  void categoryPickGoal() => emit(CategorypickerSelected(2));
  void categoryPickTask() => emit(CategorypickerSelected(3));
}
