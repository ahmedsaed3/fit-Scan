import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:train_me/widgets/helpers/my_colors.dart';

class ScanningInBody extends StatelessWidget{


  Widget build(BuildContext context){

    return Scaffold(
      backgroundColor: Colors.black,

body: Container(
  margin: EdgeInsets.only(top: 50),
  child: Column(

    children: [
      Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.only(top: 40),
          child: Text(
            'You can scan your inBody here:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),

          ),
        ),
      ),
  SizedBox(height: 5,),
      Text(
        'This helps to get the accurate workout ',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      SizedBox(height: 5,),
Center(
  child: Icon(Icons.mood,color: MyColors.Grey,
    size: 30,
  ),
),
      SizedBox(height: 50 ,),

      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        child: GestureDetector(
          onTap: () {
            //TO DO
          },
          child: Card(
            color: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/images (5).jpeg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Scanning your InBody',
                    style: TextStyle(
                      fontFamily: 'Salsa',
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
      ),

    ],


  ),
),


    );


  }



}