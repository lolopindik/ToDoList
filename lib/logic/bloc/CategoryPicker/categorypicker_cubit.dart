import 'package:flutter_bloc/flutter_bloc.dart';
part 'categorypicker_state.dart';

class CategorypickerCubit extends Cubit<CategorypickerState> {
  int? _categoryIndex;

  CategorypickerCubit({int? initialCategory})
      : _categoryIndex = initialCategory,
        super(initialCategory != null
            ? CategorypickerSelected(initialCategory)
            : CategorypickerInitial());

  void pickCategory(int index) {
    if (index >= 1 && index <= 3) {
      _categoryIndex = index;
      emit(CategorypickerSelected(_categoryIndex!));
    }
    // ignore: avoid_print, unnecessary_brace_in_string_interps
    print('CategorypickerCubit state: ${_categoryIndex}');
  }
}
