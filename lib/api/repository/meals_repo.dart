import 'package:train_me/api/model/meals_model.dart';
import 'package:train_me/api/web_services/meals_api.dart';

class MealsRepository  {
  final MealsApi mealsApi;
  MealsRepository(this.mealsApi);
  Future<List<Meals>> mealsRepo ()async{
    final meals = await mealsApi.getMeals();
    return meals.map((json) => Meals.fromJson(json as Map<String, dynamic>)).toList();

  }

}