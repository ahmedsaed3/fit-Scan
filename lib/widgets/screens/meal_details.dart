import 'package:flutter/material.dart';
import 'package:train_me/widgets/helpers/my_colors.dart';

import '../../api/model/meals_model.dart';

class MealsDetailScreen extends StatelessWidget {
  final Meals meals;

  MealsDetailScreen({required this.meals});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.LightBlack,
      appBar: AppBar(
        backgroundColor: MyColors.LightBlack,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          meals.title!,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  meals.image!,
                  height: 250,
                ),
              ),
              SizedBox(height: 16),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Protein percentage: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: MyColors.WiledGreen,
                      ),
                    ),
                    TextSpan(
                      text: meals.protein,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Fat percentage: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: MyColors.WiledGreen,
                      ),
                    ),
                    TextSpan(
                      text: meals.fat,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Carbs percentage: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: MyColors.WiledGreen,
                      ),
                    ),
                    TextSpan(
                      text: meals.carbs,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Divider(color: MyColors.WiledGreen),
              SizedBox(height: 16),
              Text(
                'Tip: A balanced diet includes an appropriate mix of protein, carbs, and fats. '
                    'Remember to stay hydrated and incorporate whole foods like fruits, vegetables, and whole grains for better nutrition.',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
