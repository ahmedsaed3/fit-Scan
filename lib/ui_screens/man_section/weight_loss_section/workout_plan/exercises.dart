import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../api/model/exercises_model.dart';
import '../../../../bloc/exercise_cubit/exercise_cubit.dart';
import '../../../../widgets/helpers/my_colors.dart';
import '../../../../widgets/screens/exercises_screen.dart';

class FullBody extends StatefulWidget {
  @override
  _FullBodyState createState() => _FullBodyState();
}

class _FullBodyState extends State<FullBody> {
  @override
  void initState() {
    super.initState();
    context.read<ExerciseCubit>().getExercises();
  }

  int selectedCategoryIndex = 0;

  final bodyPartImages = const {
    'chest': 'assets/images/8.png',
    'shoulders': 'assets/images/7.png',
    'back': 'assets/images/1.png',
    'arms': 'assets/images/6.png',
    'quads': 'assets/images/0.png',
    'abs and obliques': 'assets/images/4.png',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.LightBlack,
      appBar: AppBar(
        backgroundColor: MyColors.LightBlack,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              ' Stronger every rep, unstoppable every day 💯',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),

          Expanded(
            child: BlocBuilder<ExerciseCubit, ExerciseState>(
              builder: (context, state) {
                if (state is ExerciseInitial || state is ExercisesIsLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(MyColors.WiledGreen),
                    ),
                  );
                } else if (state is ExercisesWorked) {
                  final exercises = state.exercises;

                  final groupedExercises = {
                    'chest': exercises.where((e) => mapBodyPartName(e.bodyPart) == 'chest').toList(),
                    'shoulders': exercises.where((e) => mapBodyPartName(e.bodyPart) == 'shoulders').toList(),
                    'back': exercises.where((e) => mapBodyPartName(e.bodyPart) == 'back').toList(),
                    'arms': exercises.where((e) => mapBodyPartName(e.bodyPart) == 'arms').toList(),
                    'quads': exercises.where((e) => mapBodyPartName(e.bodyPart) == 'quads').toList(),
                    'abs and obliques': exercises.where((e) => mapBodyPartName(e.bodyPart) == 'abs and obliques').toList(),
                  };

                  return ListView.builder(
                    itemCount: groupedExercises.keys.length,
                    itemBuilder: (context, index) {
                      String bodyPart = groupedExercises.keys.elementAt(index);
                      List<Exercises> exercisesForBodyPart = groupedExercises[bodyPart]!;
                      String? imagePath = bodyPartImages[bodyPart];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BodyPartExercises(exercises: exercisesForBodyPart),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[900],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              /// **Ensure the Image is loaded properly**
                              Container(
                                height: 200, // Adjusted to prevent overflow
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                  image: imagePath != null
                                      ? DecorationImage(
                                    image: AssetImage(imagePath),
                                    fit: BoxFit.cover,
                                    onError: (error, stackTrace) {
                                      debugPrint('Error loading image: $error');
                                    },
                                  )
                                      : null,
                                ),
                                child: imagePath == null
                                    ? Center(
                                  child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                                )
                                    : null,
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.WiledGreen,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is ExercisesFailed) {
                  return Center(child: Text('Error: Failed to load data', style: TextStyle(color: Colors.red)));
                } else {
                  return Center(child: Text('No data found', style: TextStyle(color: Colors.white)));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

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
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class UpperBody extends StatefulWidget {
  @override
  _UpperBodyState createState() => _UpperBodyState();
}

class _UpperBodyState extends State<UpperBody> {
  @override
  void initState() {
    super.initState();
    // Fetch the exercises when the widget is first loaded
    context.read<ExerciseCubit>().getExercises();
  }

  final bodyPartImages = const {
    'chest': 'assets/images/8.png',
    'shoulders': 'assets/images/7.png',
    'back': 'assets/images/1.png',
    'arms': 'assets/images/6.png',
    'cardio': 'assets/images/2.png',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.LightBlack,
      appBar: AppBar(
        backgroundColor: MyColors.LightBlack,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Text(
            'Feel the burn, love the results!',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 25),
          Expanded(
            child: BlocBuilder<ExerciseCubit, ExerciseState>(
              builder: (context, state) {
                if (state is ExerciseInitial || state is ExercisesIsLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        MyColors.WiledGreen,
                      ),
                    ),
                  );
                } else if (state is ExercisesWorked) {
                  final exercises = state.exercises;

                  // Filter and group exercises by body part
                  final groupedExercises = {
                    'chest': exercises.where((exercise) => mapBodyPartName(exercise.bodyPart) == 'chest').toList(),
                    'shoulders': exercises.where((exercise) => mapBodyPartName(exercise.bodyPart) == 'shoulders').toList(),
                    'back': exercises.where((exercise) => mapBodyPartName(exercise.bodyPart) == 'back').toList(),
                    'arms': exercises.where((exercise) => mapBodyPartName(exercise.bodyPart) == 'arms').toList(),
                    'cardio': exercises.where((exercise) => mapBodyPartName(exercise.bodyPart) == 'cardio').toList(),
                  };

                  // Check if all exercise lists are empty
                  if (groupedExercises.values.every((list) => list.isEmpty)) {
                    return Center(child: Text('No exercises available', style: TextStyle(color: Colors.white)));
                  }

                  return ListView.builder(
                    itemCount: groupedExercises.keys.length,
                    itemBuilder: (context, index) {
                      String bodyPart = groupedExercises.keys.elementAt(index);
                      List<Exercises> exercisesForBodyPart = groupedExercises[bodyPart]!;
                      String imagePath = bodyPartImages[bodyPart] ?? 'assets/images/default.png';

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BodyPartExercises(exercises: exercisesForBodyPart),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 250,
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
                                    image: DecorationImage(
                                      image: AssetImage(imagePath),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  clipBehavior: Clip.hardEdge,
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.WiledGreen,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is ExercisesFailed) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: Failed to load data', style: TextStyle(color: Colors.white)),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            context.read<ExerciseCubit>().getExercises();
                          },
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(child: Text('No data found', style: TextStyle(color: Colors.white)));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Map the API body parts to user-friendly categories
  String mapBodyPartName(String apiBodyPart) {
    final bodyPartMapping = {
      'upper arms': 'arms',
      'lower arms': 'arms',
      'lower legs': 'calves',
      'upper legs': 'quads',
      'waist': 'abs and obliques',
    };
    return bodyPartMapping[apiBodyPart.toLowerCase()] ?? apiBodyPart;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////

class LowerBody extends StatefulWidget {
  @override
  _LowerBodyState createState() => _LowerBodyState();
}

class _LowerBodyState extends State<LowerBody> {
  @override
  void initState() {
    super.initState();
    // Fetch the exercises when the widget is first loaded
    context.read<ExerciseCubit>().getExercises();
  }

  int selectedCategoryIndex = 0;

  final bodyPartImages = const {
    'quads': 'assets/images/0.png',
    'calves': 'assets/images/3.png',
    'abs and obliques': 'assets/images/4.png',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.LightBlack,
      appBar: AppBar(
        backgroundColor: MyColors.LightBlack,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'One more rep, one step closer!⛓',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 25,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<ExerciseCubit, ExerciseState>(
                    builder: (context, state) {
                      if (state is ExerciseInitial ||
                          state is ExercisesIsLoading) {
                        return Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    MyColors.WiledGreen)));
                      } else if (state is ExercisesWorked) {
                        final exercises = state.exercises;

                        // Filter and group exercises by chest and shoulders
                        final groupedExercises = {
                          'quads': exercises.where((exercise) {
                            final bodyPart = mapBodyPartName(exercise.bodyPart)
                                .toLowerCase();
                            return bodyPart == 'quads';
                          }).toList(),
                          'calves': exercises.where((exercise) {
                            final bodyPart = mapBodyPartName(exercise.bodyPart)
                                .toLowerCase();
                            return bodyPart == 'calves';
                          }).toList(),
                          'abs and obliques': exercises.where((exercise) {
                            final bodyPart = mapBodyPartName(exercise.bodyPart)
                                .toLowerCase();
                            return bodyPart == 'abs and obliques';
                          }).toList(),
                        };

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: groupedExercises.keys.length,
                          itemBuilder: (context, index) {
                            String bodyPart =
                                groupedExercises.keys.elementAt(index);
                            List<Exercises> exercisesForBodyPart =
                                groupedExercises[bodyPart]!;
                            String? imagePath = bodyPartImages[bodyPart];
                            bool hasImage = imagePath != null;

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BodyPartExercises(
                                      exercises:
                                          exercisesForBodyPart, // Send all exercises for the body part
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 250,
                                margin: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20)),
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[900],
                                        borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(20)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          bodyPart,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.WiledGreen,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (state is ExercisesFailed) {
                        return Center(
                            child: Text('Error: Failed to load data'));
                      } else {
                        return Center(child: Text('No data found'));
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Map the API body parts to user-friendly categories
  String mapBodyPartName(String apiBodyPart) {
    final bodyPartMapping = {
      'upper arms': 'arms', // Combine both upper and lower arms into 'arms'
      'lower arms': 'forearm', // Both variations will be considered as 'arms'
      'lower legs': 'calves', // Combine lower and upper legs into 'legs'
      'upper legs': 'quads', // Both variations will be considered as 'legs'
      'waist': 'abs and obliques', // Abs and obliques
    };
    return bodyPartMapping[apiBodyPart.toLowerCase()] ?? apiBodyPart;
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////
class Strength extends StatefulWidget {
  @override
  _StrengthState createState() => _StrengthState();
}

class _StrengthState extends State<Strength> {
  @override
  void initState() {
    super.initState();
    // Fetch the exercises when the widget is first loaded
    context.read<ExerciseCubit>().getExercises();
  }

  int selectedCategoryIndex = 0;

  final bodyPartImages = const {
    'chest': 'assets/images/8.png',
    'shoulders': 'assets/images/7.png',
    'back': 'assets/images/1.png',
    'arms': 'assets/images/6.png',
    'quads': 'assets/images/0.png',
    'abs and obliques': 'assets/images/4.png',
    'cardio': 'assets/images/2.png',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.LightBlack,
      appBar: AppBar(
        backgroundColor: MyColors.LightBlack,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Text(
            ' Train today, triumph tomorrow💪',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 25),
          Expanded(
            child: BlocBuilder<ExerciseCubit, ExerciseState>(
              builder: (context, state) {
                if (state is ExerciseInitial || state is ExercisesIsLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              MyColors.WiledGreen)));
                } else if (state is ExercisesWorked) {
                  final exercises = state.exercises;
                  final groupedExercises = _groupExercisesByBodyPart(exercises);

                  return ListView.builder(
                    itemCount: groupedExercises.keys.length,
                    itemBuilder: (context, index) {
                      String bodyPart = groupedExercises.keys.elementAt(index);
                      List<Exercises> exercisesForBodyPart =
                      groupedExercises[bodyPart]!;
                      String? imagePath = bodyPartImages[bodyPart];
                      bool hasImage = imagePath != null;

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BodyPartExercises(
                                exercises: exercisesForBodyPart,
                              ),
                            ),
                          );
                        },
                        child: _buildExerciseCard(bodyPart, imagePath, hasImage),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('Error: Failed to load data'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Map<String, List<Exercises>> _groupExercisesByBodyPart(List<Exercises> exercises) {
    final Map<String, List<Exercises>> groupedExercises = {
      'chest': [],
      'shoulders': [],
      'back': [],
      'arms': [],
      'quads': [],
      'abs and obliques': [],
      'cardio': [],
    };
    for (var exercise in exercises) {
      final bodyPart = mapBodyPartName(exercise.bodyPart).toLowerCase();
      if (groupedExercises.containsKey(bodyPart)) {
        groupedExercises[bodyPart]!.add(exercise);
      }
    }
    return groupedExercises;
  }

  Widget _buildExerciseCard(String bodyPart, String? imagePath, bool hasImage) {
    return Container(
      width: double.infinity,
      height: 250,
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
                    ? DecorationImage(image: AssetImage(imagePath!), fit: BoxFit.cover)
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
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: MyColors.WiledGreen,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
}

/////////////////////////////////////////////////////////////////////////////////////////////////

class Cardio extends StatefulWidget {
  @override
  _CardioState createState() => _CardioState();
}

class _CardioState extends State<Cardio> {
  @override
  void initState() {
    super.initState();
    // Fetch the exercises when the widget is first loaded
    context.read<ExerciseCubit>().getExercises();
  }

  int selectedCategoryIndex = 0;

  final bodyPartImages = const {
    'cardio': 'assets/images/2.png',
    'abs and obliques': 'assets/images/4.png',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.LightBlack,
      appBar: AppBar(
        backgroundColor: MyColors.LightBlack,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Text(
            'Consistency beats perfection. Keep showing up🎯',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 25,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<ExerciseCubit, ExerciseState>(
                  builder: (context, state) {
                    if (state is ExerciseInitial ||
                        state is ExercisesIsLoading) {
                      return Center(
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  MyColors.WiledGreen)));
                    } else if (state is ExercisesWorked) {
                      final exercises = state.exercises;

                      // Filter and group exercises by chest and shoulders
                      final groupedExercises = {
                        'abs and obliques': exercises.where((exercise) {
                          final bodyPart =
                              mapBodyPartName(exercise.bodyPart).toLowerCase();
                          return bodyPart == 'abs and obliques';
                        }).toList(),
                        'cardio': exercises.where((exercise) {
                          final bodyPart =
                              mapBodyPartName(exercise.bodyPart).toLowerCase();
                          return bodyPart == 'cardio';
                        }).toList(),
                      };

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: groupedExercises.keys.length,
                        itemBuilder: (context, index) {
                          String bodyPart =
                              groupedExercises.keys.elementAt(index);
                          List<Exercises> exercisesForBodyPart =
                              groupedExercises[bodyPart]!;
                          String? imagePath = bodyPartImages[bodyPart];
                          bool hasImage = imagePath != null;

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BodyPartExercises(
                                    exercises:
                                        exercisesForBodyPart, // Send all exercises for the body part
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 250,
                              margin: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20)),
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
                                      borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(20)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        bodyPart,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.WiledGreen,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is ExercisesFailed) {
                      return Center(child: Text('Error: Failed to load data'));
                    } else {
                      return Center(child: Text('No data found'));
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Map the API body parts to user-friendly categories
  String mapBodyPartName(String apiBodyPart) {
    final bodyPartMapping = {
      'upper arms': 'arms', // Combine both upper and lower arms into 'arms'
      'lower arms': 'forearm', // Both variations will be considered as 'arms'
      'lower legs': 'calves', // Combine lower and upper legs into 'legs'
      'upper legs': 'quads', // Both variations will be considered as 'legs'
      'waist': 'abs and obliques', // Abs and obliques
    };
    return bodyPartMapping[apiBodyPart.toLowerCase()] ?? apiBodyPart;
  }
}
