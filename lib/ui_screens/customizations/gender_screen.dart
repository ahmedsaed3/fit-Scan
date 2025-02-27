import 'package:flutter/material.dart';
import 'package:train_me/widgets/helpers/Strings.dart';
import 'package:train_me/widgets/helpers/my_colors.dart';

// Declare the global variable


class Gender extends StatefulWidget {
  _GenderState createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  bool? isMan;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            color: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.1),
                Text(
                  'Identify your gender',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.04,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'This is to customize your',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
                Text(
                  'workout routine',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMan = true;
                      globalGender = 'Male'; // Update the global variable
                    });
                  },
                  child: Container(
                    height: screenHeight * 0.25,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: isMan == true ? MyColors.WiledGreen : Colors.white24,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.male,
                            color: isMan == true ? MyColors.WiledGreen : Colors.white,
                            size: screenWidth * 0.15,
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Text(
                            'Male',
                            style: TextStyle(
                              color: isMan == true ? MyColors.WiledGreen : Colors.white,
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMan = false;
                      globalGender = 'Female'; // Update the global variable
                    });
                  },
                  child: Container(
                    height: screenHeight * 0.25,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: isMan == false ? MyColors.WiledGreen : Colors.white24,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.female,
                            color: isMan == false ? MyColors.WiledGreen : Colors.white,
                            size: screenWidth * 0.15,
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Text(
                            'Female',
                            style: TextStyle(
                              color: isMan == false ? MyColors.WiledGreen : Colors.white,
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 85),
                ElevatedButton(
                  onPressed: () {
                    if (isMan == null) {
                      // Show a warning message if no gender is selected
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please select your gender!")),
                      );
                    } else {
                      Navigator.pushNamed(context, specifyAges);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.WiledGreen,
                    fixedSize: Size(300, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
