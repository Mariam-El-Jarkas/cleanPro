import 'package:flutter/material.dart';
// Uncomment below only if you're using Firebase
// import 'package:firebase_core/firebase_core.dart';

import 'pages/login.dart';
import 'pages/signup.dart';
import 'pages/account.dart';
import 'pages/help.dart';
import 'pages/home.dart'; // Make sure MainScreen is here
import 'pages/onboard1.dart';

const bool useFirebase = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (useFirebase) {
    // await Firebase.initializeApp(); // Initialize Firebase if needed
  }

  runApp(const CleanProApp());
}

class CleanProApp extends StatelessWidget {
  const CleanProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CleanPro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF6C63FF),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF6C63FF),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const OnBoardScreen1(),
        '/home': (_) => const MainScreen(),
        '/account': (_) => AccountScreen(
          initialEmail: '',
        ), // You may want to handle email dynamically
        '/help': (_) => const HelpScreen(),
        '/login': (_) => LoginScreen(
          onLoginSuccess: (email) {
            // Handle login success globally if needed
            // Or navigate to home after login:
            // Navigator.of(context).pushReplacementNamed('/home');
          },
        ),
        '/signup': (_) => const SignupScreen(),
      },
    );
  }
}
