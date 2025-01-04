import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:social_glue1/homeScreen.dart';

class SignUp1 extends StatefulWidget {
  const SignUp1({super.key});

  @override
  State<SignUp1> createState() => _SignUp1State();
}

class _SignUp1State extends State<SignUp1> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool allFieldsFilled = false;

  void _checkAllFieldsFilled() {
    setState(() {
      allFieldsFilled = nameController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          cityController.text.isNotEmpty;
    });
  }

  Future<void> saveUserData() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Map<String, String> userData = {
        'userId': user.uid,
        'phoneNumber': phoneController.text.trim(),
        'name': nameController.text.trim(),
        'city': cityController.text.trim(),
      };

      try {
        DatabaseReference userRef =
            FirebaseDatabase.instance.ref().child('users').child(user.uid);
        await userRef.set(userData);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Homescreen(),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving user data.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: User not authenticated.'),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    nameController.addListener(_checkAllFieldsFilled);
    phoneController.addListener(_checkAllFieldsFilled);
    cityController.addListener(_checkAllFieldsFilled);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.015),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.07,
                    screenHeight * 0.03,
                    0,
                    0,
                  ),
                  child: Text(
                    'Let\'s, Get\nStarted',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: screenHeight * 0.036,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                buildInputField('Enter your full name', nameController,
                    Icons.person_outlined,
                    screenWidth: screenWidth, screenHeight: screenHeight),
                SizedBox(height: screenHeight * 0.025),
                buildInputField('Enter your phone number', phoneController,
                    Icons.phone_outlined,
                    screenWidth: screenWidth, screenHeight: screenHeight),
                SizedBox(height: screenHeight * 0.025),
                buildInputField('Enter your city', cityController,
                    Icons.location_city_outlined,
                    screenWidth: screenWidth, screenHeight: screenHeight),
                SizedBox(height: screenHeight * 0.04),
                GestureDetector(
                  onTap: allFieldsFilled && !isLoading ? saveUserData : null,
                  child: Center(
                    child: Container(
                      height: screenHeight * 0.07,
                      width: screenWidth * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color:
                            allFieldsFilled ? Color(0xFF4C6CB6) : Colors.grey,
                      ),
                      child: Center(
                        child: isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontFamily: 'DMSans',
                                  fontSize: screenHeight * 0.025,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField(
    String hintText,
    TextEditingController controller,
    IconData icon, {
    required double screenWidth,
    required double screenHeight,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, size: screenHeight * 0.024),
          contentPadding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.026, horizontal: screenWidth * 0.03),
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: screenHeight * 0.015,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}
