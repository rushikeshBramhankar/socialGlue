import 'package:asthrax/authentication/changePassword.dart';
import 'package:asthrax/authentication/splash.dart';
import 'package:asthrax/homeScreen/mainHome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomePage(
        userLastName: '',
      ),
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
    ),
  );
}
