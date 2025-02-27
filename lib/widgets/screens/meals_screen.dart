import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:train_me/bloc/meals_cubit/meals_cubit.dart';
import 'package:train_me/widgets/helpers/my_colors.dart';
import 'package:train_me/widgets/screens/meal_details.dart';

class MealsScreen extends StatefulWidget {
  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MealsCubit>(context).getMeals();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.LightBlack,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: MyColors.LightBlack,
        title: TextField(
          cursorColor: MyColors.Grey,
          controller: _searchController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search meals',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
        ),
      ),
      body: BlocBuilder<MealsCubit, MealsState>(
        builder: (context, state) {
          if (state is MealsIsLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(MyColors.WiledGreen),
              ),
            );
          } else if (state is MealsWorked) {
            final meals = state.meals
                .where((meal) =>
            meal.title!.toLowerCase().contains(_searchQuery.toLowerCase()) &&
                meal.image != null && // Ensure image is not null
                meal.image!.isNotEmpty) // Ensure image is not an empty string
                .toList(); // Filter meals based on search query

            return ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return ListTile(
                  title: Text(
                    meal.title!,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Calories: ${meal.calories}',
                    style: TextStyle(color: MyColors.Grey),
                  ),
                  leading: Image.network(
                    meal.image!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error); // Fallback for error
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MealsDetailScreen(meals: meal)));
                  },
                );
              },
            );
          } else if (state is MealsFailed) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 40),
                  const SizedBox(height: 10),
                  Text(
                    'Failed to load meals',
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    state.errorMessage, // Display the error message
                    style: TextStyle(color: Colors.redAccent),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return Center(
            child: Text(
              'No meals to display',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
