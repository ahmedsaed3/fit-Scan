import 'package:flutter/material.dart';
import 'package:train_me/widgets/helpers/my_colors.dart';

class WorkoutRestDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Rest Day',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: MyColors.LightBlack,
        centerTitle: true,
      ),
      backgroundColor: MyColors.LightBlack,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              'Take a Break Today!',
              style: TextStyle(
                color: MyColors.WiledGreen,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Subtitle
            const Text(
              'Rest days are important for recovery and progress.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),

            // Cards
            RestDayCard(
              title: 'Track Your Feelings',
              description: 'Log how you feel after a week of workouts.',
              icon: Icons.mood,
              onPressed: () {
                _showCustomDialog(
                  context,
                  title: 'Feeling Tracker',
                  content: 'You can log your energy levels here.',
                );
              },
            ),
            RestDayCard(
              title: 'Recovery Tips',
              description: 'Learn ways to maximize your recovery.',
              icon: Icons.local_hospital,
              onPressed: () {
                _showCustomDialog(
                  context,
                  title: 'Recovery Tips',
                  content:
                  'Stay hydrated, eat nutritious meals, and get 7-9 hours of sleep.',
                );
              },
            ),
            RestDayCard(
              title: 'Light Activities',
              description: 'Try some yoga or light stretching.',
              icon: Icons.self_improvement,
              onPressed: () {
                _showCustomDialog(
                  context,
                  title: 'Light Activities',
                  content:
                  'Spend 10-15 minutes on light yoga or a short walk.',
                );
              },
            ),

            // Motivation
            const Spacer(),
            Center(
              child: Column(
                children: const [
                  Text(
                    'Remember, rest is part of the process!',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'See you tomorrow for another workout 💪',
                    style: TextStyle(
                      color: MyColors.WiledGreen,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showCustomDialog(BuildContext context,
      {required String title, required String content}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: MyColors.LightBlack,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          content,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class RestDayCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onPressed;

  const RestDayCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // Triggers the dialog when the card is tapped
      child: Card(
        color: Colors.grey[800],
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(icon, color: MyColors.WiledGreen, size: 30),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            description,
            style: const TextStyle(color: Colors.white70),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: MyColors.WiledGreen),
        ),
      ),
    );
  }
}

