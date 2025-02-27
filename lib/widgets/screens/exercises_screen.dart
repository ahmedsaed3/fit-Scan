import 'package:flutter/material.dart';
import 'package:train_me/widgets/helpers/my_colors.dart';
import '../../../api/model/exercises_model.dart';
import 'exercise_details.dart';

class BodyPartExercises extends StatelessWidget {

  final List<Exercises> exercises;


  BodyPartExercises({ required this.exercises, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: MyColors.LightBlack,
        title: Text(' Exercises',style: TextStyle(color:Colors.white)),
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final training = exercises[index];
          return Container(
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: MyColors.LightBlack,
              border: Border.all(color: MyColors.LightBlack),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              minVerticalPadding: 5, // Optional for layout adjustments
              title: Text(
                training.name,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Equipment: ${training.equipment}',
                style: TextStyle(color: MyColors.Grey),
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10), // Matches container's border radius
                child: Image.network(
                  training.gifUrl,
                  width: 70,
                  height: 70, // Add height for consistency
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error); // Fallback for error
                  },
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExercisesDetailScreen(exercises: training),
                  ),
                );
              },
            ),
          );

        },
      ),
    );
  }
}
