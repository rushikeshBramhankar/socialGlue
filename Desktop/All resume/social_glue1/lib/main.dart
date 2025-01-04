import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_glue1/Authentication/firstScreen.dart';
import 'package:social_glue1/homeScreen.dart';
import 'package:social_glue1/Authentication/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  );
}
