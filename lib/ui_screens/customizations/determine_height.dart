import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_me/ui_screens/customizations/determine_weight.dart';
import '../../widgets/helpers/my_colors.dart';
class DetermineHeight extends StatefulWidget {
  @override
  _DetermineHeightState createState() => _DetermineHeightState();
}

class _DetermineHeightState extends State<DetermineHeight> {
  int _selectedHeight = 140; // Default selected height

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Specify height',
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Title and Subtitle
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  'This is to customize your',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  'workout routine',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Height Picker
            Expanded(
              child: Center(

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    const Icon(
                      Icons.arrow_drop_up,
                      color:MyColors.WiledGreen,
                      size: 32,
                    ),
                    Container(
                      height: 200,
                      child: CupertinoPicker(
                        backgroundColor: Colors.black,
                        itemExtent: 50,
                        scrollController:
                        FixedExtentScrollController(initialItem: _selectedHeight - 140),
                        onSelectedItemChanged: (int index) {
                          setState(() {
                            _selectedHeight = index + 140; // Adjust based on the range
                          });
                        },
                        children: List<Widget>.generate(101, (index) {
                          int heightValue = 140 + index; // Generate heights from 140 to 240
                          return Center(
                            child: Text(
                              "$heightValue cm",
                              style: TextStyle(
                                fontSize: heightValue == _selectedHeight ? 22 : 18,
                                color: heightValue == _selectedHeight
                                    ? MyColors.WiledGreen
                                    : Colors.grey,
                                fontWeight: heightValue == _selectedHeight
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Continue Button
            ElevatedButton(
              onPressed: () async{
              int heightSelected =_selectedHeight;
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setInt('height', heightSelected);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetermineWeight()));
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
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
