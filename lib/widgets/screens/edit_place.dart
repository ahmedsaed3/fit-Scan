import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:train_me/widgets/helpers/my_colors.dart';

import '../../widgets/helpers/Strings.dart';
import 'account_edit.dart';

class EditPlace extends StatelessWidget {
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
            onTap: () {
              globalPlaceSelected = 'Gym Workout';
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => AccountEditing()));
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
            onTap: () {
              globalPlaceSelected = 'Home Workout';

              isHomeWorkoutSelected = true; // Track selection
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => AccountEditing()));
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
