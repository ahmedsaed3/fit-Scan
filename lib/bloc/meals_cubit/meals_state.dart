part of 'meals_cubit.dart';

@immutable
abstract class MealsState {}

class MealsInitial extends MealsState {}

class MealsIsLoading extends MealsState {}

class MealsWorked extends MealsState {
  final List<Meals> meals;

  MealsWorked(this.meals);
}

class MealsFailed extends MealsState {
  final String errorMessage;
  MealsFailed(this.errorMessage);
}
