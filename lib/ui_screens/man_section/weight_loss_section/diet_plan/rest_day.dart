import 'package:flutter/material.dart';
import 'package:train_me/widgets/helpers/my_colors.dart';

class DietRestDay extends StatelessWidget {
  const DietRestDay({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dietPlanGuidelines = [
      {
        'title': 'Eat Balanced Meals',
        'description': 'Incorporate proteins, carbs, and healthy fats.',
        'icon': Icons.restaurant_menu,
        'buttonText': 'Learn More',
        'route': 'BalancedMealScreen',
      },
      {
        'title': 'Hydrate Regularly',
        'description': 'Drink at least 8 cups of water daily.',
        'icon': Icons.local_drink,
        'buttonText': 'Stay Hydrated',
        'route': 'HydrationTipsScreen',
      },
      {
        'title': 'Limit Fast Food',
        'description': 'Avoid processed foods and sugary drinks.',
        'icon': Icons.no_meals,
        'buttonText': 'Find Alternatives',
        'route': 'HealthyAlternativesScreen',
      },
      {
        'title': 'Snack Smartly',
        'description': 'Choose fruits, nuts, or yogurt instead of chips.',
        'icon': Icons.fastfood,
        'buttonText': 'View Snacks',
        'route': 'SmartSnacksScreen',
      },
      {
        'title': 'Stay Positive',
        'description': 'Healthy eating is a journey, not a race.',
        'icon': Icons.mood,
        'buttonText': 'Get Motivated',
        'route': 'MotivationScreen',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Rest Day Guidelines',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: MyColors.LightBlack,
        centerTitle: true,
      ),
      backgroundColor: MyColors.LightBlack,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Added to allow scrolling
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                'Healthy Habits, Happy Life!',
                style: TextStyle(
                  color: MyColors.WiledGreen,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Subtitle
              const Text(
                'Simple steps to keep your body and mind healthy.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),

              // Loop through each guideline and create the widgets
              ...dietPlanGuidelines.map((guideline) => GuidelineCard(
                    title: guideline['title']!,
                    description: guideline['description']!,
                    icon: guideline['icon']!,
                    onPressed: () {
                      // Navigate to the respective screen
                      Navigator.pushNamed(context, guideline['route']);
                    },
                  )),

              const SizedBox(height: 5),

              // Motivation Text
              Center(
                child: Text(
                  'You’re doing amazing—keep going! 😊',
                  style: TextStyle(
                    color: MyColors.WiledGreen,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class GuidelineCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onPressed;

  const GuidelineCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
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
