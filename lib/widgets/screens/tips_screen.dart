import 'package:flutter/material.dart';
import '../helpers/my_colors.dart';

class HealthWellnessTipsScreen extends StatefulWidget {
  @override
  _HealthWellnessTipsScreenState createState() => _HealthWellnessTipsScreenState();
}

class _HealthWellnessTipsScreenState extends State<HealthWellnessTipsScreen> {
  final List<Map<String, dynamic>> tipsData = [
    {
      "category": "Nutrition",
      "tips": [
        "Drink at least 2 liters of water daily to stay hydrated.",
        "Incorporate a variety of fruits and vegetables into your diet.",
        "Choose whole-grain options over refined grains.",
        "Limit processed sugar intake to maintain energy levels."
      ],
    },
    {
      "category": "Fitness",
      "tips": [
        "Aim for at least 150 minutes of moderate-intensity exercise weekly.",
        "Warm up before and cool down after every workout session.",
        "Incorporate strength training at least twice a week.",
        "Focus on proper form to prevent injuries."
      ],
    },
    {
      "category": "Mental Health",
      "tips": [
        "Practice mindfulness meditation for 10 minutes daily.",
        "Take short breaks to reduce stress during a busy day.",
        "Spend time outdoors to boost your mood and mental clarity.",
        "Connect with friends or loved ones to strengthen emotional support."
      ],
    },
    {
      "category": "Sleep",
      "tips": [
        "Aim for 7-9 hours of quality sleep every night.",
        "Maintain a consistent sleep schedule, even on weekends.",
        "Avoid screens for at least an hour before bed.",
        "Create a relaxing bedtime routine to prepare for sleep."
      ],
    },
    {
      "category": "Recovery",
      "tips": [
        "Allow 48 hours between workouts targeting the same muscle group.",
        "Incorporate active recovery days with light stretching or yoga.",
        "Use foam rolling to relieve muscle tightness and improve flexibility.",
        "Listen to your body and rest when you feel fatigued."
      ],
    },
    {
      "category": "Hydration",
      "tips": [
        "Start your day with a glass of water to kickstart hydration.",
        "Carry a reusable water bottle to remind yourself to drink water.",
        "Add natural flavors like lemon or cucumber to make water more appealing.",
        "Drink water before, during, and after physical activity."
      ],
    },
    {
      "category": "Stress Management",
      "tips": [
        "Identify stress triggers and create a plan to manage them.",
        "Engage in activities you enjoy to unwind and recharge.",
        "Practice deep breathing exercises to calm your mind and body.",
        "Establish boundaries to protect your time and energy."
      ],
    },
    {
      "category": "Work-Life Balance",
      "tips": [
        "Set clear work hours and stick to them to avoid burnout.",
        "Schedule regular breaks to rest and recharge during work.",
        "Prioritize quality time with family and friends.",
        "Pursue hobbies or interests outside of work to maintain balance."
      ],
    },
    {
      "category": "Healthy Aging",
      "tips": [
        "Stay physically active to maintain mobility and strength.",
        "Engage in cognitive activities like puzzles or reading to sharpen your mind.",
        "Consume a balanced diet rich in calcium and vitamin D for bone health.",
        "Schedule regular health check-ups to monitor and address potential issues."
      ],
    },
    {
      "category": "Heart Health",
      "tips": [
        "Limit saturated fat and opt for healthier fats like olive oil.",
        "Engage in aerobic activities like walking, running, or swimming.",
        "Reduce sodium intake to manage blood pressure.",
        "Incorporate foods high in omega-3 fatty acids, like salmon or walnuts."
      ],
    },
  ];


  late List<bool> _expandedStates;

  @override
  void initState() {
    super.initState();
    _expandedStates = List<bool>.filled(tipsData.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.LightBlack,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Action when the back arrow is pressed
          },
        ),
        title: Text(
          "Health & Wellness Tips",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: MyColors.LightBlack,
      ),
      body: ListView.builder(
        itemCount: tipsData.length,
        itemBuilder: (context, index) {
          final category = tipsData[index];
          return Card(
            color: Colors.black,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ExpansionTile(
              collapsedIconColor: MyColors.WiledGreen,
              iconColor: MyColors.WiledGreen,
              title: Text(
                category["category"],
                style: TextStyle(
                  color: MyColors.WiledGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              initiallyExpanded: _expandedStates[index],
              onExpansionChanged: (expanded) {
                setState(() {
                  _expandedStates[index] = expanded;
                });
              },
              children: category["tips"]
                  .map<Widget>(
                    (tip) => ListTile(
                  title: Text(
                    tip,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
