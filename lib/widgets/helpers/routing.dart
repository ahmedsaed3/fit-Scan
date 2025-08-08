import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:train_me/api/repository/meals_repo.dart';
import 'package:train_me/api/web_services/meals_api.dart';
import 'package:train_me/bloc/meals_cubit/meals_cubit.dart';
import 'package:train_me/ui_screens/customizations/scan_inBody.dart';
import 'package:train_me/ui_screens/customizations/determine_age.dart';
import 'package:train_me/ui_screens/man_section/weight_loss_section/diet_plan/meals.dart';
import 'package:train_me/ui_screens/man_section/weight_loss_section/workout_plan/exercises.dart';
import 'package:train_me/ui_screens/registrations/reset_password_screen.dart';
import 'package:train_me/ui_screens/registrations/signup_screen.dart';
import 'package:train_me/widgets/screens/home_screen.dart';
import 'package:train_me/widgets/screens/account_edit.dart';
import 'package:train_me/widgets/screens/custom_exercises.dart';
import 'package:train_me/widgets/screens/help_support.dart';
import 'package:train_me/widgets/screens/meal_details.dart';
import 'package:train_me/widgets/screens/meals_screen.dart';
import 'package:train_me/widgets/screens/notification_screen.dart';
import 'package:train_me/widgets/screens/setting_screen.dart';
import 'package:train_me/widgets/screens/tips_screen.dart';
import 'package:train_me/widgets/screens/user_account.dart';
import '../../api/model/meals_model.dart';
import '../../api/repository/exercises_repo.dart';
import '../../api/web_services/exercises_api.dart';
import '../../bloc/exercise_cubit/exercise_cubit.dart';
import '../../bloc/login_cubit/google_login_cubit.dart';
import '../../ui_screens/customizations/determine_place.dart';
import '../../ui_screens/customizations/gender_screen.dart';
import '../screens/equipments/barbell_equipment.dart';
import '../screens/equipments/bodyWeight_equipment.dart';
import '../screens/equipments/cable_equipment.dart';
import '../screens/equipments/machine_equipment.dart';
import '../screens/logout_screen.dart';
import '../screens/main_screen.dart';
import '../../ui_screens/man_section/weight_loss_section/workout_plan/workout_plan.dart';
import '../../ui_screens/registrations/login_screen.dart';
import 'Strings.dart';

class Routing {
  final GoogleLoginCubit googleLoginCubit;
  final ExerciseCubit exerciseCubit;
  final ExercisesRepository exercisesRepository;
  final WebServices webServices;
  final MealsApi mealsApi;
  final MealsRepository mealsRepository;
  final MealsCubit mealsCubit;

  Routing()
      : webServices = WebServices(),
        exercisesRepository = ExercisesRepository(WebServices()),
        exerciseCubit = ExerciseCubit(ExercisesRepository(WebServices())),
        mealsApi = MealsApi(),
        mealsCubit = MealsCubit(MealsRepository(MealsApi())),
        mealsRepository = MealsRepository(MealsApi()),
        googleLoginCubit = GoogleLoginCubit();

  Route? generateRouting(RouteSettings settings) {
    switch (settings.name) {
      case gender:
        return MaterialPageRoute(
          builder: (_) => Gender(),
        );

      case loginCase:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      /*case drawer:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<GoogleLoginCubit>.value(value: googleLoginCubit),
            ],
            child: MyDrawer(),
          ),
        );*/

      case resetPassword:
        return MaterialPageRoute(builder: (_) => ForgotPassword());

      case signUp:
        return MaterialPageRoute(builder: (_) => SignUp());

      case specifyAges:
        return MaterialPageRoute(builder: (_) => DetermineAge());
      case customExercises:
        return MaterialPageRoute(builder: (_) => CustomExercises());

      case home_gym:
        return MaterialPageRoute(builder: (_) => HomeOrGym());
      case barEquipment:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: exerciseCubit,
            child: BodyPartWithBarbell(),
          ), // Pass the complete Exercises object
        );
      case cableEquipment:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: exerciseCubit,
            child: BodyPartWithCable(),
          ), // Pass the complete Exercises object
        );
      case bodyWeightEquipment:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: exerciseCubit,
            child: BodyPartWithBodyWeight(),
          ), // Pass the complete Exercises object
        );
      case machineEquipment:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: exerciseCubit,
            child: BodyPartWithMachine(),
          ), // Pass the complete Exercises object
        );


      case mealDetails:
        final Meals meals = settings.arguments as Meals; // Get the Meals object from arguments
        return MaterialPageRoute(
          builder: (_) => MealsDetailScreen(meals: meals), // Pass the complete Meals object
        );

      case inBody:
        return MaterialPageRoute(
          builder: (_) => ScanningInBody(),
        );

      case notification:
        return MaterialPageRoute(
          builder: (_) => NotificationsScreen(),
        );

      case tips:
        return MaterialPageRoute(
          builder: (_) => HealthWellnessTipsScreen(),
        );

      case setting:
        return MaterialPageRoute(
          builder: (_) => SettingsScreen(),
        );

      case helpAndSupport:
        return MaterialPageRoute(
          builder: (_) => HelpAndSupport(),
        );

      case accountEdit:
        return MaterialPageRoute(
          builder: (_) => AccountEditing(),
        );

      case userAccount:
        return MaterialPageRoute(
          builder: (_) => UserAccount(),
        );

        /////////////////////////////////////////////////////////////////////////////////////////////////////////


      case meals:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value:  mealsCubit,
                  child: MealsScreen(),
                ));
      case firstDay:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value:  mealsCubit,
              child: FirstDay(),
            ));
      case secondDay:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value:  mealsCubit,
              child: SecondDay(),
            ));
      case thirdDay:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value:  mealsCubit,
              child: ThirdDay(),
            ));
      case fourthDay:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value:  mealsCubit,
              child: FourthDay(),
            ));
      case fifthDay:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value:  mealsCubit,
              child: FifthDay(),
            ));
      case sixthDay:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value:  mealsCubit,
              child: SixthDay(),
            ));
      case weight_loss:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: exerciseCubit,
            child: HomeScreen(),
          ),
        );
      case mainScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: exerciseCubit),
              BlocProvider.value(value: mealsCubit),
            ],
            child: MainScreen(),
          ),
        );

      case weightLossWorkoutPlan:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: exerciseCubit,
            child: WeightLossWorkoutPlan(),
          ),
        );
      case fullBody:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: exerciseCubit,
            child: FullBody(),
          ),
        );
      case upperBody:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: exerciseCubit,
            child: UpperBody(),
          ),
        );
      case lowerBody:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: exerciseCubit,
            child: LowerBody(),
          ),
        );
      case strength:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: exerciseCubit,
            child: Strength(),
          ),
        );
      case cardio:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: exerciseCubit,
            child: Cardio(),
          ),
        );


    }
  }
}
