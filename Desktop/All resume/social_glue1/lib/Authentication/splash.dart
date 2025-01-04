import 'dart:async';
import 'package:flutter/material.dart';
import 'package:social_glue1/Authentication/firstScreen.dart';
import 'package:social_glue1/homeScreen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigate to the home screen after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Entryscreen()), // Replace with your home screen
      );
    });

    return Scaffold(
      backgroundColor: Colors.grey[50], // Background color of the splash screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Center(
              child: Image.asset(
                'assets/logo.png', // Replace with your logo path
                height: 300,
                width: 300,
              ),
            ),
            SizedBox(height: 20),
            // App Name
            // Text.rich(
            //   TextSpan(
            //     children: [
            //       TextSpan(
            //         text: 'Online',
            //         style: TextStyle(
            //           color: Color.fromARGB(255, 218, 136, 13),
            //           fontSize: 24,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //       TextSpan(
            //         text: ' Shop',
            //         style: TextStyle(
            //           color: Color.fromARGB(255, 10, 77, 133),
            //           fontSize: 24,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
