import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_glue1/Authentication/firstScreen.dart';
import 'package:social_glue1/Authentication/login.dart';
import 'package:social_glue1/Authentication/signup1.dart';
import 'package:social_glue1/homeScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  Color _emailBorderColor = Colors.black;
  Color _passwordBorderColor = Colors.black;
  bool _isLoading = false;

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

  Future<void> _registerWithEmailAndPassword() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());

      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignUp1(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  top: screenHeight * 0.01,
                  left: screenWidth * 0.06,
                ),
                child: Container(
                  height: screenHeight * 0.05,
                  width: screenHeight * 0.05,
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
                      size: screenWidth * 0.07,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.08,
                ),
                child: Text(
                  'Create,\nNew\nAccount',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.07),
              // Email TextField
              Center(
                child: Container(
                  height: screenHeight * 0.07,
                  width: screenWidth * 0.9,
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
                        contentPadding:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.grey,
                          size: screenWidth * 0.07,
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                          fontSize: screenWidth * 0.04,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.036),
              // Password TextField
              Center(
                child: Container(
                  height: screenHeight * 0.07,
                  width: screenWidth * 0.9,
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
                        contentPadding:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.grey,
                          size: screenWidth * 0.07,
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                          fontSize: screenWidth * 0.04,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.07),
              // Sign Up Button
              GestureDetector(
                onTap: _registerWithEmailAndPassword,
                child: Center(
                  child: Container(
                    height: screenHeight * 0.07,
                    width: screenWidth * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Color(0xFF4C6CB6),
                    ),
                    child: Center(
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Sign Up",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.05,
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
                        builder: (context) => EmailPasswordAuth(),
                      ),
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize:
                                screenWidth * 0.03, // Responsive font size
                          ),
                        ),
                        TextSpan(
                          text: 'Log in',
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
