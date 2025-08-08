import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/helpers/my_colors.dart';
import '../../muscle_gain_section/workout_plan/workout_plan.dart';

class StartGainMuscleWorkout extends StatelessWidget {
  final String? previousScreen;
  const StartGainMuscleWorkout({Key? key, this.previousScreen}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: MyColors.LightBlack, // Light gray background
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor:MyColors.LightBlack, // Same as background
        elevation: 0,
        title: const Text(
          "Workout Plan",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 500,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: const Color(0xFFF5F5F5),
                backgroundImage: AssetImage('assets/images/gym.jpg'),
                onBackgroundImageError: (error, stackTrace) => const Icon(
                  Icons.error,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Gain Muscles in 30 Days",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Feel the burn,\n love the results!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: MyColors.LightBlack,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  MuscleGainWorkoutPlan()));

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.LightBlack, // Blue color
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ), child: Text('Start',style: TextStyle(color: MyColors.WiledGreen),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
