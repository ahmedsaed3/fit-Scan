import 'package:flutter/material.dart';
import 'package:train_me/widgets/helpers/my_colors.dart';
import 'dart:async';

import '../../widgets/helpers/Strings.dart';

class ProgressScreen extends  StatefulWidget {
  final String? homeArea;
  const ProgressScreen({this.homeArea,super.key});

  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    _startProgress();
  }

  void _startProgress() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if (_progressValue >= 1.0) {
          timer.cancel(); // Stop the timer when progress reaches 100%.
          Navigator.pushReplacementNamed(context, mainScreen); // Navigate to the next screen.
        } else {
          _progressValue += 0.01; // Increment progress value.
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.LightBlack,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Minimize column size to content.
          children: [
            const CircleAvatar(
              radius: 50, 
              backgroundImage: AssetImage('assets/images/freepik-untitled-project-202502222126512ePt.png'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Analyzing details to craft your journey...',
              style: TextStyle(
                color: MyColors.Grey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: CircularProgressIndicator(
                    value: _progressValue,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey[300],
                    color: MyColors.WiledGreen,
                  ),
                ),
                Text(
                  '${(_progressValue * 100).toInt()}%',
                  style: const TextStyle(
                    color: MyColors.WiledGreen,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
