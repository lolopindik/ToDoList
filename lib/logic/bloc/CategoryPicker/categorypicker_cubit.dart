import 'package:flutter_bloc/flutter_bloc.dart';
part 'categorypicker_state.dart';

class CategorypickerCubit extends Cubit<CategorypickerState> {
  CategorypickerCubit({int? initialCategory})
      : super(initialCategory != null
            ? CategorypickerSelected(initialCategory)
            : CategorypickerInitial());
  void categoryPickEvent() => emit(CategorypickerSelected(1));
  void categoryPickGoal() => emit(CategorypickerSelected(2));
  void categoryPickTask() => emit(CategorypickerSelected(3));
}
