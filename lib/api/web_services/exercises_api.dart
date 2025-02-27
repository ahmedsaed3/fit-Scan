import 'package:dio/dio.dart';
import '../../widgets/helpers/Strings.dart';

class WebServices {
  final Dio dio = Dio();
  Future<List<dynamic>> getExercises() async {

    try {
      Response response = await dio.get(
        exercisesUrl,
        options: Options(
          headers: {
            'X-RapidAPI-host': apiHost,
            'X-RapidAPI-Key': exerciseApiKey,
          },
        ),
      );

return response.data;

    } catch (e) {
      throw Exception('Failed to load trainings: $e');
    }
  }

  }




