import 'package:flutter/material.dart';
import 'package:train_me/widgets/helpers/my_colors.dart';

import '../../../api/model/exercises_model.dart';

class ExercisesDetailScreen extends StatelessWidget {
  final Exercises exercises;

  ExercisesDetailScreen({required this.exercises});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.LightBlack,
      appBar: AppBar(
        backgroundColor: MyColors.LightBlack,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          exercises.name,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    exercises.gifUrl,
                    height: 250,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Body Part: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                    TextSpan(
                      text: exercises.bodyPart,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Equipment: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                    TextSpan(
                      text: exercises.equipment,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Target: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                    TextSpan(
                      text: exercises.target,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Secondary Muscles:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              ...exercises.secondaryMuscles.map(
                    (muscle) => Text(
                  '- $muscle',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Instructions:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              ...exercises.instructions.map(
                    (instruction) => Text(
                  '- $instruction',
                  style: TextStyle(color: MyColors.Grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
