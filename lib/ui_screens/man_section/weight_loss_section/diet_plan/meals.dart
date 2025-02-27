import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:train_me/bloc/meals_cubit/meals_cubit.dart';
import 'package:train_me/widgets/helpers/my_colors.dart';
import 'package:train_me/widgets/screens/meal_details.dart';

class FirstDay extends StatefulWidget {
  @override
  State<FirstDay> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<FirstDay> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MealsCubit>(context).getMeals();
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
        title: const Text('Meals', style: TextStyle(color: Colors.white)),
      ),
      body: BlocBuilder<MealsCubit, MealsState>(
        builder: (context, state) {
          if (state is MealsIsLoading) {
            return Center(
              child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(MyColors.WiledGreen)),
            );
          } else if (state is MealsWorked) {
            // Define the allowed meal titles, categories, and colors
            final mealCategoryMap = {
              "Almond and cranberry shortbread": "Breakfast",
              "Apple Cheddar Turkey Burgers With Chipotle Yogurt Sauce":
                  "Lunch",
              "Apple Sausage Galette": "Dinner",
            };

            final categoryColors = {
              "Breakfast": Colors.orange,
              "Lunch": Colors.blue,
              "Dinner": Colors.purple,
            };

            // Filter meals based on the defined titles
            final meals = state.meals
                .where((meal) => mealCategoryMap.containsKey(meal.title))
                .toList();

            if (meals.isEmpty) {
              return Center(
                child: Text(
                  'No meals matching the criteria',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                final category =
                    mealCategoryMap[meal.title]; // Get the category
                final categoryColor = categoryColors[category]; // Get the color

                return ListTile(
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$category: ',
                          style: TextStyle(
                              color: categoryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: meal.title!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
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
///////////////////////////////////////////////////////////////////////////////////////////////////////////

class SecondDay extends StatefulWidget {
  @override
  _SecondDayState createState() => _SecondDayState();
}

class _SecondDayState extends State<SecondDay> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MealsCubit>(context).getMeals();
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
        title: const Text('Meals', style: TextStyle(color: Colors.white)),
      ),
      body: BlocBuilder<MealsCubit, MealsState>(
        builder: (context, state) {
          if (state is MealsIsLoading) {
            return Center(
              child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(MyColors.WiledGreen)),
            );
          } else if (state is MealsWorked) {
            // Define the allowed meal titles, categories, and colors
            final mealCategoryMap = {
              "Applesauce Carrot Cake Muffins": "Breakfast",
              "Baked Cheese Manicotti": "Lunch",
              "Balsamic & Honey Glazed Salmon with Lemony Asparagus": "Dinner",
            };

            final categoryColors = {
              "Breakfast": Colors.orange,
              "Lunch": Colors.blue,
              "Dinner": Colors.purple,
            };

            // Filter meals based on the defined titles
            final meals = state.meals
                .where((meal) => mealCategoryMap.containsKey(meal.title))
                .toList();

            if (meals.isEmpty) {
              return Center(
                child: Text(
                  'No meals matching the criteria',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                final category =
                    mealCategoryMap[meal.title]; // Get the category
                final categoryColor = categoryColors[category]; // Get the color

                return ListTile(
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$category: ',
                          style: TextStyle(
                              color: categoryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: meal.title!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
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
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ThirdDay extends StatefulWidget {
  @override
  _ThirdDayState createState() => _ThirdDayState();
}

class _ThirdDayState extends State<ThirdDay> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MealsCubit>(context).getMeals();
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
        title: const Text('Meals', style: TextStyle(color: Colors.white)),
      ),
      body: BlocBuilder<MealsCubit, MealsState>(
        builder: (context, state) {
          if (state is MealsIsLoading) {
            return Center(
              child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(MyColors.WiledGreen)),
            );
          } else if (state is MealsWorked) {
            // Define the allowed meal titles, categories, and colors
            final mealCategoryMap = {
              "Best Cream Of Tomato Soup": "Breakfast",
              "Blueberry Loaf With Blueberry Syrup": "Lunch",
              "Broccoli Cheddar Soup": "Dinner",
            };

            final categoryColors = {
              "Breakfast": Colors.orange,
              "Lunch": Colors.blue,
              "Dinner": Colors.purple,
            };

            // Filter meals based on the defined titles
            final meals = state.meals
                .where((meal) => mealCategoryMap.containsKey(meal.title))
                .toList();

            if (meals.isEmpty) {
              return Center(
                child: Text(
                  'No meals matching the criteria',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                final category =
                    mealCategoryMap[meal.title]; // Get the category
                final categoryColor = categoryColors[category]; // Get the color

                return ListTile(
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$category: ',
                          style: TextStyle(
                              color: categoryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: meal.title!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
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

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class FourthDay extends StatefulWidget {
  @override
  _FourthDayState createState() => _FourthDayState();
}

class _FourthDayState extends State<FourthDay> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MealsCubit>(context).getMeals();
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
        title: const Text('Meals', style: TextStyle(color: Colors.white)),
      ),
      body: BlocBuilder<MealsCubit, MealsState>(
        builder: (context, state) {
          if (state is MealsIsLoading) {
            return Center(
              child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(MyColors.WiledGreen)),
            );
          } else if (state is MealsWorked) {
            // Define the allowed meal titles, categories, and colors
            final mealCategoryMap = {
              "Brussels Sprout With Mustard And Honey": "Breakfast",
              "Cashew Nut Chicken": "Lunch",
              "Chicken and White Bean Chili": "Dinner",
            };

            final categoryColors = {
              "Breakfast": Colors.orange,
              "Lunch": Colors.blue,
              "Dinner": Colors.purple,
            };

            // Filter meals based on the defined titles
            final meals = state.meals
                .where((meal) => mealCategoryMap.containsKey(meal.title))
                .toList();

            if (meals.isEmpty) {
              return Center(
                child: Text(
                  'No meals matching the criteria',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                final category =
                    mealCategoryMap[meal.title]; // Get the category
                final categoryColor = categoryColors[category]; // Get the color

                return ListTile(
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$category: ',
                          style: TextStyle(
                              color: categoryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: meal.title!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////

class FifthDay extends StatefulWidget {
  @override
  _FifthDayState createState() => _FifthDayState();
}

class _FifthDayState extends State<FifthDay> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MealsCubit>(context).getMeals();
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
        title: const Text('Meals', style: TextStyle(color: Colors.white)),
      ),
      body: BlocBuilder<MealsCubit, MealsState>(
        builder: (context, state) {
          if (state is MealsIsLoading) {
            return Center(
              child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(MyColors.WiledGreen)),
            );
          } else if (state is MealsWorked) {
            // Define the allowed meal titles, categories, and colors
            final mealCategoryMap = {
              "Chicken Pasta Primavera - Flower Patch Farmgirl Style":
                  "Breakfast",
              "Chicken Stew For The Soul": "Lunch",
              "Chipotle Black Bean Soup with Avocado Cream": "Dinner",
            };

            final categoryColors = {
              "Breakfast": Colors.orange,
              "Lunch": Colors.blue,
              "Dinner": Colors.purple,
            };

            // Filter meals based on the defined titles
            final meals = state.meals
                .where((meal) => mealCategoryMap.containsKey(meal.title))
                .toList();

            if (meals.isEmpty) {
              return Center(
                child: Text(
                  'No meals matching the criteria',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                final category =
                    mealCategoryMap[meal.title]; // Get the category
                final categoryColor = categoryColors[category]; // Get the color

                return ListTile(
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$category: ',
                          style: TextStyle(
                              color: categoryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: meal.title!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
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

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class SixthDay extends StatefulWidget {
  @override
  _SixthDayState createState() => _SixthDayState();
}

class _SixthDayState extends State<SixthDay> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MealsCubit>(context).getMeals();
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
        title: const Text('Meals', style: TextStyle(color: Colors.white)),
      ),
      body: BlocBuilder<MealsCubit, MealsState>(
        builder: (context, state) {
          if (state is MealsIsLoading) {
            return Center(
              child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(MyColors.WiledGreen)),
            );
          } else if (state is MealsWorked) {
            // Define the allowed meal titles, categories, and colors
            final mealCategoryMap = {
              "Fruit Crepe": "Breakfast",
              "Easy Baked Parmesan Chicken": "Lunch",
              "Fennel-Tomato Linguine": "Dinner",
            };

            final categoryColors = {
              "Breakfast": Colors.orange,
              "Lunch": Colors.blue,
              "Dinner": Colors.purple,
            };

            // Filter meals based on the defined titles
            final meals = state.meals
                .where((meal) => mealCategoryMap.containsKey(meal.title))
                .toList();

            if (meals.isEmpty) {
              return Center(
                child: Text(
                  'No meals matching the criteria',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                final category =
                    mealCategoryMap[meal.title]; // Get the category
                final categoryColor = categoryColors[category]; // Get the color

                return ListTile(
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$category: ',
                          style: TextStyle(
                              color: categoryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: meal.title!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
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
