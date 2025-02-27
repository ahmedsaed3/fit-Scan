import '../model/exercises_model.dart';
import '../web_services/exercises_api.dart';

class ExercisesRepository {
 final WebServices webServices;
 ExercisesRepository (this.webServices);
  Future<List<Exercises>> ExercisesRepo ()async{
final training = await webServices.getExercises();
return training.map((json) => Exercises.fromJson(json as Map<String, dynamic>)).toList();

  }




}