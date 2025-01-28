import 'package:buzz_tech/constants/preferences.dart';
import 'package:buzz_tech/logic/bloc/CategoryPicker/categorypicker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CategoryPickerWidget {
  final int? initialCategory;

  CategoryPickerWidget({this.initialCategory});

  Widget buildCategoryPicker(BuildContext context) {
    final cubit = context.read<CategorypickerCubit>();

    if (initialCategory != null && cubit.state is CategorypickerInitial) {
      cubit.pickCategory(initialCategory!);
    }

    return BlocBuilder<CategorypickerCubit, CategorypickerState>(
      builder: (context, state) {
        double categorySize = MediaQuery.of(context).size.height * 0.07;
        double selectedCategorySize =
            MediaQuery.of(context).size.height * 0.085;

        int? selectedCategoryIndex = state is CategorypickerSelected
            ? state.categoryIndex
            : initialCategory;

        List<Map<String, dynamic>> categories = [
          {
            'iconPath': 'lib/assets/icons/Category=Event.svg',
            'index': 1,
          },
          {
            'iconPath': 'lib/assets/icons/Category=Goal.svg',
            'index': 2,
          },
          {
            'iconPath': 'lib/assets/icons/Category=Task.svg',
            'index': 3,
          },
        ];

        return Row(
          children: [
            const Text(
              'Category',
              style: ToDoTextStyles.black16,
            ),
            const SizedBox(width: 24),
            ...categories.map((category) {
              int categoryIndex = category['index'] as int;
              bool isSelected = selectedCategoryIndex == categoryIndex;

              return IconButton(
                onPressed: () {
                  cubit.pickCategory(categoryIndex);

                  if (cubit.state is CategorypickerSelected) {
                    final selectedCategory =
                        (cubit.state as CategorypickerSelected).categoryIndex;
                    debugPrint('Selected category: $selectedCategory');
                  } else {
                    debugPrint(
                        'Current state is not CategorypickerSelected: ${cubit.state}');
                  }
                },
                icon: SvgPicture.asset(
                  category['iconPath'],
                  height: isSelected ? selectedCategorySize : categorySize,
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
