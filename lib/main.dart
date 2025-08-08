import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_me/widgets/helpers/Strings.dart';
import 'package:train_me/widgets/helpers/routing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:train_me/bloc/login_cubit/google_login_cubit.dart';

late String initialRout;

/// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Initialize Firebase for background messages
  await Firebase.initializeApp();
  print("Background message received: ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Firebase messaging background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Determine the initial route based on authentication state
  /*FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user == null) {
      initialRout = loginCase; // If not logged in, go to login screen
    } else {

      initialRout = mainScreen; // If logged in, go to gender selection screen
    }
  });*/

  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    initialRout = mainScreen; // User has logged in before, go to main screen
  } else {
    initialRout = loginCase; // User is not logged in
  }

  // Run the app and ensure that routing and provider for GoogleLoginCubit are set up properly
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/language', // Directory for translation files
      fallbackLocale: Locale('en'),
      child: MultiProvider(  // Add MultiProvider to wrap your app with providers
        providers: [
          BlocProvider<GoogleLoginCubit>(create: (_) => GoogleLoginCubit()), // Provide the GoogleLoginCubit
        ],
        child: MyApp(routing: Routing()),  // Pass routing to MyApp
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.routing});
  final Routing routing;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        splashFactory: NoSplash.splashFactory, // Removes splash effect
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale, // Automatically updates
      debugShowCheckedModeBanner: false,
      onGenerateRoute: routing.generateRouting, // Handle routing
      initialRoute: initialRout, // Use the initialRoute set by the auth listener
    );
  }
}
