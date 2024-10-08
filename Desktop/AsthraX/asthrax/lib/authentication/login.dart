import 'package:asthrax/authentication/forgotpassword.dart';
import 'package:asthrax/authentication/signUp.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          children: [
            Image.asset('assets/logo.png', height: 30), // Your AstharaX logo
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Text
            Text(
              "Welcome back! Glad to see you again!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Email/Phone Number Field
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Enter Email/Phone Number",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),

            // Password Field with View Password Option
            TextField(
              controller: passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: "Enter Password",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 10),

            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage()),
                  );
                },
                child: Text("Forgot Password?"),
              ),
            ),

            SizedBox(height: 20),

            // Login Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                // Implement login logic
              },
              child: Center(
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Divider with "or login with"
            Row(
              children: <Widget>[
                Expanded(child: Divider(thickness: 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("or login with"),
                ),
                Expanded(child: Divider(thickness: 1)),
              ],
            ),

            SizedBox(height: 20),

            // Social Login Buttons (Facebook, Google, Apple)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.facebook),
                  // icon: Image.asset('assets/facebook_icon.png'),
                  iconSize: 50,
                  onPressed: () {
                    // Facebook login logic
                  },
                ),
                IconButton(
                  icon: Icon(Icons.g_mobiledata),
                  // icon: Image.asset('assets/google_icon.png'),
                  iconSize: 50,
                  onPressed: () {
                    // Google login logic
                  },
                ),
                IconButton(
                  icon: Icon(Icons.apple),
                  // icon: Image.asset('assets/apple_icon.png'),
                  iconSize: 50,
                  onPressed: () {
                    // Apple login logic
                  },
                ),
              ],
            ),

            SizedBox(height: 30),

            // Register Now Option
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: Text(
                    "Register Now",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
