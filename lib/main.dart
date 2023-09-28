import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:untitled/LoginPage.dart';
import 'package:untitled/signUpPage.dart';

import 'Home.dart';
import 'SplashScreen.dart';
import 'firebase_options.dart';

Future main() async {
  // Or with fallback.
  await dotenv.load(fileName: ".env");
  //Initilized Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      home: const SplashScreen(),
      routes: {
        "/signUpPage": (context) => const signUp(),
        "/logInPage": (context) => const loginPage(),
        "/afterLogIn": (context) => const Home(),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}
