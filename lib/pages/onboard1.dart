import 'package:flutter/material.dart';

class OnBoardScreen1 extends StatelessWidget {
  const OnBoardScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 5,
                child: SizedBox(
                  child: Image.asset(
                    '/images/image.png', // no leading slash
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Text(
                      'Welcome to cleanPro',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 217, 124, 18),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 34),
                    Text(
                      'Your trusted partner for professional cleaning services.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(), // keeps the Next button at the bottom
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/Home'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 217, 124, 18),
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 21,
                          color: Colors.black, // ← make the text black
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
