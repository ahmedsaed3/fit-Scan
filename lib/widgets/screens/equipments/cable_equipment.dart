import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:train_me/widgets/helpers/my_colors.dart';
import '../../../bloc/exercise_cubit/exercise_cubit.dart';
import '../exercise_details.dart';

class BodyPartWithCable extends StatefulWidget {
  @override
  _BodyPartWithCableState createState() => _BodyPartWithCableState();
}

class _BodyPartWithCableState extends State<BodyPartWithCable> {
  @override
  void initState() {
    super.initState();

    context.read<ExerciseCubit>().getExercises();
  }

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
        title: Text('Exercises', style: TextStyle(color: Colors.white)),
      ),
      body: BlocBuilder<ExerciseCubit, ExerciseState>(
        builder: (context, state) {
          if (state is ExercisesIsLoading) {
            return Center(child: CircularProgressIndicator(
              color: MyColors.WiledGreen,
            ));
          } else if (state is ExercisesWorked) {
            // Filter exercises to include only those with "barbell" equipment
            final barbellExercises = state.exercises
                .where((exercise) => exercise.equipment.toLowerCase() == 'cable')
                .toList();

            return barbellExercises.isNotEmpty
                ? ListView.builder(
              itemCount: barbellExercises.length,
              itemBuilder: (context, index) {
                final training = barbellExercises[index];
                return Container(
                  height: 100,
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: MyColors.LightBlack,
                    border: Border.all(color: MyColors.LightBlack),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    minVerticalPadding: 5,
                    title: Text(
                      training.name,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Equipment: ${training.equipment}',
                      style: TextStyle(color: MyColors.Grey),
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        training.gifUrl,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.error);
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
            )
                : Center(
              child: Text(
                'No barbell exercises found.',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          } else if (state is ExercisesFailed) {
            return Center(
              child: Text(
                'Failed to load exercises.',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          }
          return Center(
            child: Text(
              'Unexpected state.',
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
          );
        },
      ),
    );
  }
}
