import 'package:bloc_to_do/constants/preferences.dart';
import 'package:bloc_to_do/logic/bloc/CategoryPicker/categorypicker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CategoryPickerWidget {
  Widget buildCategoryPicker(BuildContext context) {
    return BlocBuilder<CategorypickerCubit, CategorypickerState>(
      builder: (context, state) {
        double categorySize = MediaQuery.of(context).size.height * 0.07;
        double selectedCategorySize =
            MediaQuery.of(context).size.height * 0.085;
        if (state is CategorypickerSelected) {
          int selectedCategoryIndex = state.categoryIndex;
          debugPrint('Selected category index: $selectedCategoryIndex');
        }
        return Row(
          children: [
            const Text(
              'Category',
              style: ToDoTextStyles.black16,
            ),
            const SizedBox(width: 24),
            //* Too lazy to rewrite
            IconButton(
              onPressed: () {
                context.read<CategorypickerCubit>().categoryPickEvent();
              },
              icon: SvgPicture.asset('lib/assets/icons/Category=Event.svg',
                  height: (state is CategorypickerSelected &&
                          state.categoryIndex == 1)
                      ? selectedCategorySize
                      : categorySize),
            ),
            IconButton(
              onPressed: () {
                context.read<CategorypickerCubit>().categoryPickGoal();
              },
              icon: SvgPicture.asset('lib/assets/icons/Category=Goal.svg',
                  height: (state is CategorypickerSelected &&
                          state.categoryIndex == 2)
                      ? selectedCategorySize
                      : categorySize),
            ),
            IconButton(
              onPressed: () {
                context.read<CategorypickerCubit>().categoryPickTask();
              },
              icon: SvgPicture.asset('lib/assets/icons/Category=Task.svg',
                  height: (state is CategorypickerSelected &&
                          state.categoryIndex == 3)
                      ? selectedCategorySize
                      : categorySize),
            ),
          ],
        );
      },
    );
  }
}
