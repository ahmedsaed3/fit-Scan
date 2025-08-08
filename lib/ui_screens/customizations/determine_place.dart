import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_me/ui_screens/customizations/determine_goals.dart';
import 'package:train_me/widgets/helpers/my_colors.dart';
import '../../widgets/helpers/Strings.dart';

class HomeOrGym extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Specify place',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          GestureDetector(
            onTap: () async{
              String placeSelected ='Gym Workout';
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('place', placeSelected);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CustomizeGoals()));
            },
            child: Card(
              color: MyColors.LightBlack,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/sddefault.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Gym Workout',
                      style: TextStyle(
                        color: MyColors.WiledGreen,
                        fontFamily: 'Abel',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,

                        //fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          // Gain Muscle Card

          GestureDetector(
            onTap: ()async {

              String placeSelected ='Home Workout';
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('place', placeSelected);

              isHomeWorkoutSelected = true; // Track selection
              Navigator.push(context, MaterialPageRoute(builder: (context) => CustomizeGoals()));
            },
            child: Card(
              color: MyColors.LightBlack,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/depositphotos_233087794-stock-photo-strong-racial-man-doing-exercise.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Home Workout',
                      style: TextStyle(
                        fontFamily: 'Abel',
                        color: MyColors.WiledGreen,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
