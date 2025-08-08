import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_me/widgets/helpers/Strings.dart';

import '../../widgets/helpers/my_colors.dart';

class DetermineWeight extends StatefulWidget {
  @override
  _DetermineWeightState createState() => _DetermineWeightState();
}

class _DetermineWeightState extends State<DetermineWeight> {
  int _selectedWeight = 40; // Default selected weight

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Specify weight',
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
            // Weight Picker
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Triangle Indicator
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
                        FixedExtentScrollController(initialItem: 0),
                        onSelectedItemChanged: (int index) {
                          setState(() {
                            _selectedWeight = index + 40; // Adjust based on range
                          });
                        },
                        children: List<Widget>.generate(161, (index) {
                          int weightValue = 40 + index; // Generate weights from 50 to 150
                          return Center(
                            child: Text(
                              "$weightValue kg",
                              style: TextStyle(
                                fontSize: weightValue == _selectedWeight ? 22 : 18,
                                color: weightValue == _selectedWeight
                                    ? MyColors.WiledGreen
                                    : Colors.grey,
                                fontWeight: weightValue == _selectedWeight
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
                int WeightSelected=_selectedWeight;
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setInt('weight', WeightSelected);

                 Navigator.pushNamed(context, home_gym);
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
