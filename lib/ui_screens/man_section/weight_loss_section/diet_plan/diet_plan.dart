import 'package:flutter/material.dart';
import 'package:train_me/ui_screens/man_section/weight_loss_section/diet_plan/rest_day.dart';
import 'package:train_me/widgets/helpers/Strings.dart';
import 'package:train_me/widgets/helpers/my_colors.dart';

import 'meals.dart';

class WeightLossDietPlan extends StatelessWidget {
  const WeightLossDietPlan({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dietPlan = [
      // First 7 days
      {'day': 'Day 1', 'description': 'Meal Plan', 'buttonText': 'View', 'route': firstDay},
      {'day': 'Day 2', 'description': 'Meal Plan', 'buttonText': 'View', 'route': secondDay},
      {'day': 'Day 3', 'description': 'Meal Plan', 'buttonText': 'View', 'route': thirdDay},
      {'day': 'Day 4', 'description': 'Meal Plan', 'buttonText': 'View', 'route': fourthDay},
      {'day': 'Day 5', 'description': 'Meal Plan', 'buttonText': 'View', 'route': fifthDay},
      {'day': 'Day 6', 'description': 'Meal Plan', 'buttonText': 'View', 'route': sixthDay},
      {'day': 'Day 7', 'description': 'Rest Day', 'buttonText': 'View', 'customRoute': (context) => DietRestDay()},
      // Repeated 7 days (Days 8-14)
      {'day': 'Day 8', 'description': 'Meal Plan', 'buttonText': 'View', 'route': firstDay},
      {'day': 'Day 9', 'description': 'Meal Plan', 'buttonText': 'View', 'route': secondDay},
      {'day': 'Day 10', 'description': 'Meal Plan', 'buttonText': 'View', 'route': thirdDay},
      {'day': 'Day 11', 'description': 'Meal Plan', 'buttonText': 'View', 'route': fourthDay},
      {'day': 'Day 12', 'description': 'Meal Plan', 'buttonText': 'View', 'route': fifthDay},
      {'day': 'Day 13', 'description': 'Meal Plan', 'buttonText': 'View', 'route': sixthDay},
      {'day': 'Day 14', 'description': 'Rest Day', 'buttonText': 'View', 'customRoute': (context) => DietRestDay()},

      // Repeated 7 days (Days 15-21)
      {'day': 'Day 15', 'description': 'Meal Plan', 'buttonText': 'View', 'route': firstDay},
      {'day': 'Day 16', 'description': 'Meal Plan', 'buttonText': 'View', 'route': secondDay},
      {'day': 'Day 17', 'description': 'Meal Plan', 'buttonText': 'View', 'route': thirdDay},
      {'day': 'Day 18', 'description': 'Meal Plan', 'buttonText': 'View', 'route': fourthDay},
      {'day': 'Day 19', 'description': 'Meal Plan', 'buttonText': 'View', 'route': fifthDay},
      {'day': 'Day 20', 'description': 'Meal Plan', 'buttonText': 'View', 'route': sixthDay},
      {'day': 'Day 21', 'description': 'Rest Day', 'buttonText': 'View', 'customRoute': (context) => DietRestDay()},
      // Repeated 7 days (Days 22-28)
      {'day': 'Day 22', 'description': 'Meal Plan', 'buttonText': 'View', 'route': firstDay},
      {'day': 'Day 23', 'description': 'Meal Plan', 'buttonText': 'View', 'route': secondDay},
      {'day': 'Day 24', 'description': 'Meal Plan', 'buttonText': 'View', 'route': thirdDay},
      {'day': 'Day 25', 'description': 'Meal Plan', 'buttonText': 'View', 'route': fourthDay},
      {'day': 'Day 26', 'description': 'Meal Plan', 'buttonText': 'View', 'route': fifthDay},
      {'day': 'Day 27', 'description': 'Meal Plan', 'buttonText': 'View', 'route': sixthDay},
      {'day': 'Day 28', 'description': 'Rest Day', 'buttonText': 'View  ', 'customRoute': (context) => DietRestDay()},
      // Repeated 2 days (Days 29-30)
      // Repeated 7 days (Days 22-28)
      {'day': 'Day 29', 'description': 'Meal Plan', 'buttonText': 'View', 'route': firstDay},
      {'day': 'Day 30', 'description': 'Meal Plan', 'buttonText': 'View', 'route': secondDay},
    ];




    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF111417), size: 24),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Lose Weight in 30 Days',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111417),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Diet Plan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111417),
                ),
              ),
              const SizedBox(height: 16),
              // Loop through each workout day and create the widgets
              ...dietPlan.map((workout) => _buildWorkoutDay(
                day: workout['day']!,
                description: workout['description']!,
                buttonText: workout['buttonText']!,
                onPressed: () {
                  // Navigate to the custom route or named route
                  if (workout.containsKey('customRoute')) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: workout['customRoute']!),
                    );
                  } else {
                    Navigator.pushNamed(context, workout['route']);
                  }
                },
              )),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to build each workout day card
  Widget _buildWorkoutDay({
    required String day,
    required String description,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed, // Navigate when tapping anywhere on the card
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: MyColors.LightBlack,
          border: Border.all(color: MyColors.LightBlack),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: MyColors.WiledGreen,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: MyColors.Grey,
                  ),
                ),
              ],
            ),
            // Button to start or track the workout
            ElevatedButton(
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: TextStyle(color: MyColors.WiledGreen), // Set text color here
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Set your button color here
              ),
            ),
          ],
        ),
      ),
    );
  }
}

