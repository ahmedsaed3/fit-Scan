import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:train_me/api/repository/meals_repo.dart';

import '../../api/model/meals_model.dart';

part 'meals_state.dart';

class MealsCubit extends Cubit<MealsState> {
  final MealsRepository mealsRepository;
  MealsCubit(this.mealsRepository) : super(MealsInitial());
  List<Meals> _meals =[];
  void getMeals() async {
    emit(MealsIsLoading());
    try {
      final meals = await mealsRepository.mealsRepo();
      _meals = meals; // Save fetched exercises
      emit(MealsWorked(_meals));
    } catch (e) {
      emit(MealsFailed(e.toString())); // Capture error message
    }
  }

}
