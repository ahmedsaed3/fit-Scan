import 'package:dio/dio.dart';
import 'package:train_me/api/model/meals_model.dart';
import 'package:train_me/widgets/helpers/Strings.dart';

class MealsApi {

  final Dio dio = Dio();

  Future<List<dynamic>> getMeals() async {
    try {
      Response response = await dio.get(
        mealsUrl,
        queryParameters: {
          'minCarbs': 10,
          'maxCarbs': 50,
          'number': 300,
          'maxProtein': 100,
          'minProtein': 10,
          'minCalories': 50,
          'maxCalories': 500,
          'apiKey': mealsApiKey,
        },

      );

      return response.data;


    } catch (e) {
      throw Exception('Failed to load meals: $e');
    }
  }




}