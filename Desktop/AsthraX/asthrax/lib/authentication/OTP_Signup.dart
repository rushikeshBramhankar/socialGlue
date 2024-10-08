import 'package:asthrax/homeScreen/mainHome.dart';
import 'package:flutter/material.dart';

class OtpVerificationPage extends StatefulWidget {
  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController otpController1 = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController otpController3 = TextEditingController();
  final TextEditingController otpController4 = TextEditingController();

  bool isOtpIncorrect = false;

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 30), // AstharaX Logo
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Box with shadow and content
              Container(
                padding: const EdgeInsets.all(20),
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
                  children: [
                    // Heading
                    Text(
                      "Verify OTP",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),

                    // Body Text
                    Text(
                      "Please verify OTP that we've sent to your email",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 20),

                    // OTP Input Fields
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildOtpBox(otpController1),
                        _buildOtpBox(otpController2),
                        _buildOtpBox(otpController3),
                        _buildOtpBox(otpController4),
                      ],
                    ),

                    SizedBox(height: 20),

                    // Incorrect OTP message
                    if (isOtpIncorrect)
                      Text(
                        "Incorrect OTP",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),

                    SizedBox(height: 20),

                    // Verify Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        _verifyOtp();
                      },
                      child: Text(
                        "Verify",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // OTP Box Widget
  Widget _buildOtpBox(TextEditingController controller) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
        ),
      ),
    );
  }

  // Verify OTP Logic (Sample, replace with your logic)
  void _verifyOtp() {
    String otp = otpController1.text +
        otpController2.text +
        otpController3.text +
        otpController4.text;

    if (otp == "1234") {
      // Mock correct OTP for testing
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => HomePage(
                  userLastName: '',
                )), // Redirect to Home Page after verification
      );
    } else {
      setState(() {
        isOtpIncorrect = true;
      });
    }
  }
}
