import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/helpers/my_colors.dart';
import 'determine_height.dart';

int globalAge = 15;

class DetermineAge extends StatefulWidget {
  @override
  _DetermineAgeState createState() => _DetermineAgeState();
}

class _DetermineAgeState extends State<DetermineAge> {
  int _selectedAge = 0; // Default selected weight

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Specify age',
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      color: MyColors.WiledGreen,
                      size: 32,
                    ),
                    Container(
                      height: 200,
                      child: CupertinoPicker(
                        backgroundColor: Colors.black,
                        itemExtent: 50,
                        scrollController: FixedExtentScrollController(
                            initialItem: _selectedAge),
                        onSelectedItemChanged: (int index) {
                          setState(() {
                            _selectedAge = index + 15; // Adjust based on range
                          });
                        },
                        children: List<Widget>.generate(86, (index) {
                          int ageValue =
                              15 + index; // Generate weights from 50 to 150
                          return Center(
                            child: Text(
                              "$ageValue ",
                              style: TextStyle(
                                fontSize: ageValue == _selectedAge ? 22 : 18,
                                color: ageValue == _selectedAge
                                    ? MyColors.WiledGreen
                                    : Colors.grey,
                                fontWeight: ageValue == _selectedAge
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
              onPressed: () {
                // print('Selected Age: $globalAge'); // Debugging purpose
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetermineHeight()),
                );
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
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
