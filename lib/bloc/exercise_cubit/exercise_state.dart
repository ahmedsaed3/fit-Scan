part of 'exercise_cubit.dart';

@immutable
abstract class ExerciseState {}

class ExerciseInitial extends ExerciseState {}

class ExercisesIsLoading extends ExerciseState {}

class ExercisesWorked extends ExerciseState {
  final List<Exercises> exercises;

  ExercisesWorked(this.exercises);
}

class ExercisesFailed extends ExerciseState {}

