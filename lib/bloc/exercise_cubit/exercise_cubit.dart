import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../api/model/exercises_model.dart';
import '../../api/repository/exercises_repo.dart';
part 'exercise_state.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  ExerciseCubit(this.exercisesRepository) : super(ExerciseInitial());

  final ExercisesRepository exercisesRepository;
  List<Exercises> _exercises = []; // Store all exercises for filtering

  // Fetch exercises from the repository
  void getExercises() async {
    emit(ExercisesIsLoading());
    try {
      final trainings = await exercisesRepository.ExercisesRepo();
      _exercises = trainings; // Save fetched exercises
      emit(ExercisesWorked(_exercises));
    } catch (e) {
      emit(ExercisesFailed()); // Capture error message
    }
  }

  // Filters exercises by category (bodyPart)
  void filterByCategory(String category) {
    if (category == 'All') {
      emit(ExercisesWorked(_exercises)); // Emit all exercises if "All" is selected
    } else {
      final filteredExercises = _exercises.where((exercise) {
        final mappedBodyPart = mapBodyPartName(exercise.bodyPart);
        return mappedBodyPart.toLowerCase().contains(category.toLowerCase());
      }).toList();

      emit(ExercisesWorked(filteredExercises)); // Emit only filtered exercises
    }
  }

  // Map the API body parts to user-friendly categories (same as in UI)
  String mapBodyPartName(String apiBodyPart) {
    final bodyPartMapping = {
      'upper arms': 'arms',    // Combine both upper and lower arms into 'arms'
      'lower arms': 'forearm',    // Both variations will be considered as 'arms'
      'lower legs': 'calves',    // Combine lower and upper legs into 'legs'
      'upper legs': 'quads',    // Both variations will be considered as 'legs'
      'waist': 'abs and obliques',  // Abs and obliques
    };
    return bodyPartMapping[apiBodyPart.toLowerCase()] ?? apiBodyPart;
  }
}
