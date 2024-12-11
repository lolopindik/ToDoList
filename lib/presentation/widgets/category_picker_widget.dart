import 'package:bloc_to_do/constants/preferences.dart';
import 'package:bloc_to_do/logic/bloc/CategoryPicker/categorypicker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CategoryPickerWidget {
  final int? initialCategory;

  CategoryPickerWidget({this.initialCategory});

  Widget buildCategoryPicker(BuildContext context) {
    return BlocProvider(
      create: (_) => CategorypickerCubit(initialCategory: initialCategory),
      child: BlocBuilder<CategorypickerCubit, CategorypickerState>(
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
              'onPressed': () =>
                  context.read<CategorypickerCubit>().categoryPickEvent(),
              'index': 1,
            },
            {
              'iconPath': 'lib/assets/icons/Category=Goal.svg',
              'onPressed': () =>
                  context.read<CategorypickerCubit>().categoryPickGoal(),
              'index': 2,
            },
            {
              'iconPath': 'lib/assets/icons/Category=Task.svg',
              'onPressed': () =>
                  context.read<CategorypickerCubit>().categoryPickTask(),
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
                bool isSelected = selectedCategoryIndex == category['index'];
                return IconButton(
                  onPressed: category['onPressed'],
                  icon: SvgPicture.asset(
                    category['iconPath'],
                    height: isSelected ? selectedCategorySize : categorySize,
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
