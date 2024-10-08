import 'package:asthrax/authentication/OTP_Signup.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 80),
            SizedBox(height: 40),

            // Big box with shadow effect
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    spreadRadius: 1.0,
                    offset: Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back arrow button
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop(); // Navigate back
                    },
                  ),

                  // Heading "Forgot Password"
                  Text(
                    "Forgot Password",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 10),

                  // Body Text
                  Text(
                    "Please enter your email or phone number, and we will send an OTP",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),

                  SizedBox(height: 20),

                  TextField(
                    controller: emailPhoneController,
                    decoration: InputDecoration(
                      labelText: "Enter Email/Phone Number",
                      border: OutlineInputBorder(),
                      errorText: emailPhoneController.text.isEmpty
                          ? 'This field is required'
                          : null,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      if (emailPhoneController.text.isNotEmpty) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => OtpVerificationPage()),
                        );
                      } else {
                        setState(() {});
                      }
                    },
                    child: Text("Verify", style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
