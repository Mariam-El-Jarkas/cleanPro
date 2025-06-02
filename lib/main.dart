import 'package:flutter/material.dart';
import 'pages/onboard1.dart';
import 'pages/Home.dart';
import 'pages/account.dart';
import 'pages/help.dart';
// import 'pages/services_details.dart';

void main() {
  runApp(CleanProApp());
}

class CleanProApp extends StatelessWidget {
  const CleanProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CleanPro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF6C63FF),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => OnBoardScreen1(),
        '/Home': (context) => MainScreen(),
        '/account': (context) => AccountScreen(),
        '/help': (context) => HelpScreen(),
      },
    );
  }
}
