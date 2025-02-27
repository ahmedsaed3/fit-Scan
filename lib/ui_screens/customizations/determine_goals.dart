import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:train_me/ui_screens/customizations/progressing.dart';
import 'package:train_me/widgets/helpers/my_colors.dart';

class CustomizeGoals extends StatelessWidget {
   final bool? isHome;
    late final String homePlace;

  CustomizeGoals({Key? key, this.isHome}) : super(key: key) {
    homePlace = isHome == true ? "home" : "notHome";
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Specify goals',
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProgressScreen()),
              );
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
                            'assets/images/Blog_Images_Push_Myself_800x.webp'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      ' Weight Loss',
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProgressScreen()),
              );
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
                          'assets/images/1308025.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Muscle Gain',
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
