import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:second_laboratory_exercise/firebase_options.dart';
import 'package:second_laboratory_exercise/screens/categories.dart';
import 'package:second_laboratory_exercise/screens/meal_details.dart';
import 'package:second_laboratory_exercise/screens/meals.dart';
import 'package:second_laboratory_exercise/services/notification_service.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  final notificationService = NotificationService();
  await notificationService.initFCM();

  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

  runApp(const MyApp());

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'MealDeal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(237, 242, 251, 1)),
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: const CategoriesScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/meals": (context) {
          final category = ModalRoute.of(context)!.settings.arguments as String;
          return MealsScreen(category: category);
        },
        "/mealDetails": (context) {
          final mealId = ModalRoute.of(context)!.settings.arguments as String;
          return MealDetailScreen(mealId: mealId);
        },
      },
    );
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message)async{
    print('Message: ${message.notification?.title}');
}