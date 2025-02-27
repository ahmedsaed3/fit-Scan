import 'package:flutter/material.dart';
import 'package:train_me/widgets/helpers/my_colors.dart';

import '../../ui_screens/customizations/determine_age.dart';
import '../helpers/Strings.dart';

int globalAge2 = 15;
class ChangeAge extends StatefulWidget {
  @override
  _AgeInputStepperScreenState createState() => _AgeInputStepperScreenState();
}

class _AgeInputStepperScreenState extends State<ChangeAge> {
  late PageController con;
  int currentValue = 0; // Tracks the current index of the PageView

  @override
  void initState() {
    super.initState();

    // Use globalAge if it has a valid value, otherwise default to 15
    if (globalAge < 15 || globalAge > 100) {
      globalAge = 15;
    }

    // Sync globalAge2 to match globalAge
    globalAge2 = globalAge;

    // Initialize PageController based on the current globalAge
    con = PageController(
      viewportFraction: 0.2,
      initialPage: globalAge - 15, // Convert globalAge to the corresponding index
    );
  }

  Widget _surroundingBars() {
    return Center(
      child: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(
              2,
                  (index) => const Divider(
                thickness: 3,
                color: MyColors.WiledGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 40),
                child: const Text(
                  'Change age',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Spacer(),
            Center(
              child: SizedBox(
                height: 350,
                width: 75,
                child: Stack(
                  children: [
                    _surroundingBars(),
                    PageView(
                      physics: const BouncingScrollPhysics(),
                      controller: con,
                      scrollDirection: Axis.vertical,
                      onPageChanged: (index) {
                        setState(() {
                          currentValue = index;
                          globalAge2 = index + 15; // Update globalAge2 correctly
                          globalAge = globalAge2; // Sync globalAge with globalAge2
                        });
                      },
                      children: List.generate(86, (index) {
                        int age = index + 15; // Calculate age based on index
                        return Center(
                          child: Text(
                            age.toString(),
                            style: TextStyle(
                              fontSize: currentValue == index
                                  ? 40
                                  : (currentValue == index - 1 || currentValue == index + 1)
                                  ? 30
                                  : 22,
                              color: currentValue == index
                                  ? MyColors.WiledGreen
                                  : (currentValue == index - 1 || currentValue == index + 1)
                                  ? Colors.grey
                                  : Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                print('Selected Age: $globalAge'); // Debugging purpose
                Navigator.pushNamed(context, accountEdit);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.WiledGreen,
                fixedSize: const Size(300, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Center(
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
