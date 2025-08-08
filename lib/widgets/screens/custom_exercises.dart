import 'package:flutter/material.dart';
import 'package:train_me/widgets/helpers/Strings.dart';
import 'package:train_me/widgets/helpers/my_colors.dart';
class CustomExercises extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Custom Workouts', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
       /* leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),*/
      ),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 400, // Set height to accommodate card height
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  BarbellCard(
                    context,
                    'assets/images/Gym_12.23-19.webp',
                    'Barbell Equipment',
                  ),
                  CableCard(
                    context,
                    'assets/images/Gym_12.23-19.webp', // Replace with your image path
                    'Cable Equipment',
                  ),
                  BodyWeightCard(
                    context,
                    'assets/images/Gym_12.23-19.webp', // Replace with your image path
                    'BodyWeight Equipment',
                  ),
                  MachineCard(
                    context,
                    'assets/images/Gym_12.23-19.webp', // Replace with your image path
                    'Machine Equipment',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget BarbellCard(BuildContext context, String imagePath, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, barEquipment);
      },

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 200,
        height: 350,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: MyColors.LightBlack,
            width:1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                width: 195,
                height: 300,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: MyColors.WiledGreen,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'Abel',

              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget CableCard(BuildContext context, String imagePath, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, cableEquipment);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 200,
        height: 350,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: MyColors.LightBlack,
            width:1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                width: 195,
                height: 300,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: MyColors.WiledGreen,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'Abel',

              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget BodyWeightCard(BuildContext context,String imagePath, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, bodyWeightEquipment);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 200,
        height: 350,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: MyColors.LightBlack,
            width:1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                width: 195,
                height: 300,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: MyColors.WiledGreen,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'Abel',

              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget MachineCard(BuildContext context,String imagePath, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, machineEquipment);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 200,
        height: 350,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: MyColors.LightBlack,
            width:1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                width: 195,
                height: 300,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: MyColors.WiledGreen,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'Abel',

              ),
            ),
          ],
        ),
      ),
    );
  }

}
