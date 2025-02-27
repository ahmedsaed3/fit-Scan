import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/model/exercises_model.dart';
import '../../bloc/exercise_cubit/exercise_cubit.dart';
import '../../ui_screens/customizations/determine_goals.dart';
import 'Strings.dart';
import 'my_colors.dart';
import '../screens/exercises_screen.dart';

class ExercisesBlocBuilder extends StatefulWidget {
  const ExercisesBlocBuilder({Key? key, }) : super(key: key);

  @override
  State<ExercisesBlocBuilder> createState() => _ExercisesBlocBuilderState();
}

class _ExercisesBlocBuilderState extends State<ExercisesBlocBuilder> {
   late final CustomizeGoals customizeGoals;

  @override
  void initState() {
    super.initState();
    customizeGoals = CustomizeGoals();
    context.read<ExerciseCubit>().getExercises();
  }

  final List<String> muscles = [
    'All',
    'shoulders',
    'forearm',
    'arms',
    'cardio',
    'chest',
    'calves',
    'back',
    'quads',
    'abs and obliques',
  ];

  int selectedCategoryIndex = 0;

  final bodyPartImages = const {
    'quads': 'assets/images/11.png',
    'chest': 'assets/images/8.png',
    'calves': 'assets/images/9.png',
    'arms': 'assets/images/7.png',
    'back': 'assets/images/12.png',
    'shoulders': 'assets/images/shoulder.png',
    'forearm': 'assets/images/3.png',
    'abs and obliques': 'assets/images/abb.png',
    'cardio': 'assets/images/2.png',
  };

  // Filters exercises by category (bodyPart)
  List<Exercises> filterByCategory(List<Exercises> exercises, String category) {
    if (category == 'All') {
      return exercises; // Show all exercises if 'All' is selected
    }

    return exercises.where((exercise) {
      final mappedBodyPart = mapBodyPartName(exercise.bodyPart);
      // Check if the category is contained in the mapped body part name
      return mappedBodyPart.toLowerCase().contains(category.toLowerCase());
    }).toList();
  }

  // Map the API body parts to user-friendly categories
  String mapBodyPartName(String apiBodyPart) {
    final bodyPartMapping = {
      'upper arms': 'arms',
      'lower arms': 'forearm',
      'lower legs': 'calves',
      'upper legs': 'quads',
      'waist': 'abs and obliques',
    };
    return bodyPartMapping[apiBodyPart.toLowerCase()] ?? apiBodyPart;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(muscles.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategoryIndex = index;
                        context.read<ExerciseCubit>().filterByCategory(muscles[index]);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                      decoration: BoxDecoration(
                        color: selectedCategoryIndex == index
                            ? MyColors.WiledGreen
                            : Colors.grey[900],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        muscles[index],
                        style: TextStyle(
                          fontFamily: 'Abel',
                          color: selectedCategoryIndex == index
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
            BlocBuilder<ExerciseCubit, ExerciseState>(
            builder: (context, state) {
              if (state is ExerciseInitial || state is ExercisesIsLoading) {
                return Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(MyColors.WiledGreen)));
              } else if (state is ExercisesWorked) {
                final exercises = state.exercises;
                final filteredExercises =
                filterByCategory(exercises, muscles[selectedCategoryIndex]);

                // Group exercises by their body part
                Map<String, List<Exercises>> groupedExercises = {};
                for (var exercise in filteredExercises) {
                  String mappedBodyPart = mapBodyPartName(exercise.bodyPart);
                  if (groupedExercises.containsKey(mappedBodyPart)) {
                    groupedExercises[mappedBodyPart]!.add(exercise);
                  } else {
                    groupedExercises[mappedBodyPart] = [exercise];
                  }
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: groupedExercises.keys.length,
                  itemBuilder: (context, index) {
                    String bodyPart = groupedExercises.keys.elementAt(index);
                    List<Exercises> exercisesForBodyPart = groupedExercises[bodyPart]!;

                    String? imagePath = bodyPartImages[bodyPart];
                    bool hasImage = imagePath != null;
                    return GestureDetector(
                      onTap: () {
                        if (customizeGoals.homePlace == 'home') {
                          Navigator.pushNamed(context, bodyWeightEquipment);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BodyPartExercises(
                                exercises: exercisesForBodyPart,
                              ),
                            ),
                          );
                        }
                      },

                      child:Container(
                        width: double.infinity,
                        height: 300,
                        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                  image: hasImage
                                      ? DecorationImage(
                                    image: AssetImage(imagePath),
                                    fit: BoxFit.cover,
                                  )
                                      : null,
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: hasImage
                                    ? null
                                    : Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 45,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                              ),
                              child: Center(
                                child: Text(
                                  bodyPart,
                                  style: TextStyle(
                                    fontFamily: 'Abel',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.WiledGreen,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      ,
                    );
                  },
                );
              } else if (state is ExercisesFailed) {
                return Center(
                    child: Text(
                      'Error: Failed to load data',
                      style: TextStyle(
                        fontFamily: 'Abel',
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ));
              } else {
                return Center(
                    child: Text(
                      'No data found',
                      style: TextStyle(
                        fontFamily: 'Abel',
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ));
              }
            },
          ),
        ],
      ),
    );
  }
}
