import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_glue1/Authentication/firstScreen.dart';
import 'package:social_glue1/Authentication/signup.dart';
import 'package:social_glue1/homeScreen.dart';

class EmailPasswordAuth extends StatefulWidget {
  const EmailPasswordAuth({super.key});

  @override
  State<EmailPasswordAuth> createState() => _EmailPasswordAuthState();
}

class _EmailPasswordAuthState extends State<EmailPasswordAuth> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  Color _emailBorderColor = Colors.black;
  Color _passwordBorderColor = Colors.black;
  bool _isLoading = false; // To track the loading state

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode()
      ..addListener(() {
        setState(() {
          _emailBorderColor =
              _emailFocusNode.hasFocus ? Color(0xFF0077B5) : Colors.black;
        });
      });
    _passwordFocusNode = FocusNode()
      ..addListener(() {
        setState(() {
          _passwordBorderColor =
              _passwordFocusNode.hasFocus ? Color(0xFF0077B5) : Colors.black;
        });
      });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _signInWithEmailAndPassword() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());

      if (userCredential.user != null) {
        // Navigate to HomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Homescreen(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Stop loading if there's an error
      setState(() {
        _isLoading = false;
      });

      String errorMessage = 'Please enter the correct email/password';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password.';
      }
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }

    // Stop loading after sign in process is complete
    setState(() {
      _isLoading = false;
    });
  }
// In your build method, update the relevant parts

  @override
  Widget build(BuildContext context) {
    // Get device height and width for responsive design
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.01, // 3% of screen height
                  left: screenWidth * 0.06, // 8% of screen width
                ),
                child: Container(
                  height: screenHeight * 0.05, // 7% of screen height
                  width: screenHeight * 0.05, // Make it square
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Entryscreen(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back_sharp,
                      size: screenWidth * 0.07, // Responsive size
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05), // 5% of screen height
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.08, // 8% of screen width
                ),
                child: Text(
                  'Hey,\nWelcome\nBack',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontSize: screenWidth * 0.08, // Adjust the size
                    fontWeight: FontWeight.w700, // Bold for better emphasis
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.07), // 8% of screen height
              // Email TextField
              Center(
                child: Container(
                  height: screenHeight * 0.07, // Responsive height
                  width: screenWidth * 0.9, // 90% of screen width
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: _emailBorderColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: emailController,
                      focusNode: _emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        contentPadding: EdgeInsets.symmetric(
                            vertical:
                                screenHeight * 0.02), // Center the hint text
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.grey,
                          size: screenWidth * 0.07, // Responsive icon size
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                          fontSize: screenWidth * 0.04, // Responsive font size
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.036), // 3% of screen height
              // Password TextField
              Center(
                child: Container(
                  height: screenHeight * 0.07, // Responsive height
                  width: screenWidth * 0.9, // 90% of screen width
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: _passwordBorderColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: passwordController,
                      focusNode: _passwordFocusNode,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter password',
                        contentPadding: EdgeInsets.symmetric(
                            vertical:
                                screenHeight * 0.02), // Center the hint text
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.grey,
                          size: screenWidth * 0.07, // Responsive icon size
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                          fontSize: screenWidth * 0.04, // Responsive font size
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.07), // 6% of screen height
              // Login Button
              GestureDetector(
                onTap: _signInWithEmailAndPassword,
                child: Center(
                  child: Container(
                    height: screenHeight * 0.07, // Responsive height
                    width: screenWidth * 0.9, // 90% of screen width
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Color(0xFF4C6CB6),
                    ),
                    child: Center(
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Login",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    screenWidth * 0.05, // Responsive font size
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.005), // 3% of screen height
              // Sign-up Button
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ),
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize:
                                screenWidth * 0.03, // Responsive font size
                          ),
                        ),
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                screenWidth * 0.03, // Responsive font size
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
