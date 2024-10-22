part of 'categorypicker_cubit.dart';

abstract class CategorypickerState{
  const CategorypickerState();
}

class CategorypickerInitial extends CategorypickerState {}

class CategorypickerSelected extends CategorypickerState{
  final int categoryIndex;

  CategorypickerSelected(this.categoryIndex);
}