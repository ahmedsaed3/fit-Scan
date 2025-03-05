import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:train_me/widgets/helpers/Strings.dart';
import 'package:train_me/widgets/helpers/routing.dart';
import 'package:easy_localization/easy_localization.dart';
late String  initialRout;
/// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Initialize Firebase for background messages
  await Firebase.initializeApp();
  print("Background message received: ${message.notification?.title}");
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  //final notificationService = NotificationService();
  //   final now = DateTime.now();
  //   final notificationTime = now.add(const Duration(seconds:  10)); // 10 seconds later
  //
  //   notificationService.scheduleNotification(
  //     id: 1,
  //     title: 'Time to Exercise!',
  //     body: 'Don\'t forget your workout routine today!',
  //     scheduledDateTime: notificationTime,
  //   );

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseAuth.instance.authStateChanges().listen((user) {
    if(user == null){
      initialRout =  loginCase;

    }
    else{

      initialRout= gender ;

    }

  });
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/language', // Directory for translation files
      fallbackLocale: Locale('en'),
      child: MyApp(routing: Routing(),),
    ),
  );


  //EasyLocalization(
  //         supportedLocales: [Locale('en'), Locale('ar')],
  //         path: 'assets/translations', // Path to your translation files
  //         fallbackLocale: Locale('en'), // Default locale
  //         child: MyApp(),
  //       ),
  //
  //       MyApp(routing: Routing(),));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.routing});
final Routing routing ;
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale, // Automatically updates
      debugShowCheckedModeBanner: false,
      onGenerateRoute: routing.generateRouting,
      initialRoute: initialRout,
    );
  }
}

