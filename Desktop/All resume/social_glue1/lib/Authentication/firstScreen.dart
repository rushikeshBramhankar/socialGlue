import 'package:flutter/material.dart';
import 'package:social_glue1/Authentication/login.dart';
import 'package:social_glue1/Authentication/signup.dart';
import 'package:social_glue1/homeScreen.dart';

class Entryscreen extends StatefulWidget {
  const Entryscreen({super.key});

  @override
  State<Entryscreen> createState() => _EntryscreenState();
}

class _EntryscreenState extends State<Entryscreen> {
  bool isLoginSelected = true;

  @override
  Widget build(BuildContext context) {
    // Get device height and width
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.14), // 5% of screen height

            // Adjusted space between images
            Center(
              child: Image.asset(
                'assets/logo.png',
                height: screenHeight * 0.30, // 33% of screen height
                width: screenWidth * 0.9, // 80% of screen width
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // 5% of screen height

            // Updated text for e-commerce platform
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '              Shop the Best ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: screenWidth * 0.07, // Responsive font size
                    ),
                  ),
                  TextSpan(
                    text: '\n                    Deals',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4C6CB6),
                      fontSize: screenWidth * 0.07, // Responsive font size
                    ),
                  ),
                  TextSpan(
                    text: ' \n    with Amazing Discounts !!!',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: screenWidth * 0.07, // Responsive font size
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.15), // 8% of screen height

            Center(
              child: Container(
                height: screenHeight * 0.07, // Responsive height
                width: screenWidth * 0.9, // Responsive width
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max, // Ensure it takes full space
                  children: [
                    // Login Button
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isLoginSelected = true;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EmailPasswordAuth(),
                            ),
                          );
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color: isLoginSelected
                                ? Color(0xFF4C6CB6)
                                : Colors.transparent,
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(35),
                              right: Radius.circular(isLoginSelected ? 35 : 0),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color:
                                  isLoginSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  screenWidth * 0.045, // Responsive font size
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isLoginSelected = false;
                          });
                          // Navigate to Sign-up Screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          );
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color: isLoginSelected
                                ? Colors.transparent
                                : Color(0xFF4C6CB6),
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(isLoginSelected ? 0 : 35),
                              right: Radius.circular(35),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Sign-up',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color:
                                  isLoginSelected ? Colors.black : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  screenWidth * 0.045, // Responsive font size
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
