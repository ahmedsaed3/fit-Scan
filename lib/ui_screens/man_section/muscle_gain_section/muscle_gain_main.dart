import 'package:flutter/material.dart';
import 'package:train_me/ui_screens/man_section/muscle_gain_section/workout_plan/start_workout.dart';

import '../../../widgets/helpers/bloc_builder_helper.dart';
import '../../../widgets/helpers/my_colors.dart';
import '../../../widgets/screens/drawer_widget.dart';
import '../weight_loss_section/diet_plan/start_diet.dart';

class MuscleGainMain extends StatelessWidget {
  //MuscleGainMain({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      drawer: Drawer(backgroundColor: MyColors.LightBlack, child: MyDrawer()),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, color: MyColors.Grey),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset(
                'assets/images/Black and Yellow Gym Center Logo.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 5),
            Text(
              "Let's crush those goals.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'Abel',
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Workout Plan card
                  // Diet Plan card
                  _buildInfoCard(
                    title: 'Diet Plan',
                    imagePath: 'assets/images/Getty_1047798504_1920x1080.jpg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StartDietPlan()),
                      );
                    },
                  ),
                  _buildInfoCard(
                    title: 'Workout Plan',
                    imagePath: 'assets/images/360_F_178986435_zhT6Mfe9c5rXF8w78wHvbpDLHekfgIHV.jpg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StartGainMuscleWorkout(previousScreen: 'MuscleGain')),
                      );
                    },
                  ),
                ],
              ),
            ),
            ExercisesBlocBuilder(),
          ],
        ),
      ),
    );
  }
}


Widget _buildInfoCard({
  required String title,
  required String imagePath,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap, // Pass the correct navigation logic
    child: Container(
      height: 250,
      width: 250,
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: MyColors.LightBlack,
        border: Border.all(color: MyColors.LightBlack, width: 5),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Abel',
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}