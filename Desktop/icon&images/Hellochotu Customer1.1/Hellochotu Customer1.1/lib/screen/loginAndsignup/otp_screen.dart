// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, unnecessary_brace_in_string_interps, avoid_print, sort_child_properties_last, unrelated_type_equality_checks, sized_box_for_whitespace

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hellochotu/controller/login_controller.dart';
import 'package:hellochotu/controller/signup_controller.dart';
import 'package:hellochotu/model/fontfamily_model.dart';
import 'package:hellochotu/screen/loginAndsignup/resetpassword_screen.dart';
import 'package:hellochotu/utils/Colors.dart';
import 'package:hellochotu/utils/Custom_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../controller/msg_otp_controller.dart';
import '../../controller/sms_type_controller.dart';
import '../../controller/twilio_otp_controller.dart';

class OtpScreen extends StatefulWidget {
  String? ccode;
  String? number;
  String? FullName;
  String? Email;
  String? Password;
  String? Signup;
  String? otpCode;
  String? msgType;

  OtpScreen(
      {this.msgType,
      this.otpCode,
      this.FullName,
      this.Email,
      this.Password,
      this.ccode,
      this.number,
      this.Signup,
      super.key});
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController pinPutController = TextEditingController();
  LoginController loginController = Get.find();
  SignUpController signUpController = Get.find();
  SmsTypeController smsTypeController = Get.put(SmsTypeController());
  MsgOtpController msgOtpController = Get.put(MsgOtpController());
  TwilioOtpController twilioOtpController = Get.put(TwilioOtpController());

  FirebaseAuth auth = FirebaseAuth.instance;

  String code = "";
  // String phoneNumber = Get.arguments["number"];

  // String countryCode = Get.arguments["cuntryCode"];

  // String rout = Get.arguments["route"];

  String verrification = "";

  @override
  void initState() {
    startTimer();
    setState(() {
      verrification = widget.Signup ?? "";
    });
    super.initState();
  }

  int secondsRemaining = 30;
  bool enableResend = false;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: Container(
          color: transparent,
          height: Get.height,
          child: Stack(
            children: [
              Stack(
                children: [
                  Container(
                    height: Get.height * 0.4,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(gradient: gradient.btnGradient),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.14,
                        ),
                        Text(
                          "Let’s Confirm it’s you!".tr,
                          style: TextStyle(
                            color: WhiteColor,
                            fontFamily: FontFamily.gilroyBold,
                            fontSize: 25,
                            letterSpacing: 1.1,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Text(
                          "Complete verification process".tr,
                          style: TextStyle(
                            color: WhiteColor,
                            fontFamily: FontFamily.gilroyMedium,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 0,
                    child: SizedBox(
                      height: Get.size.height * 0.23,
                      width: Get.size.width * 0.4,
                      child: Image.asset(
                        "assets/otp.png",
                        height: Get.size.height * 0.2,
                        width: Get.size.width * 0.6,
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                top: Get.height * 0.32,
                child: Container(
                  height: Get.height,
                  width: Get.width * 0.9,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "${"We have sent the code verification to".tr}\n${widget.ccode} ${widget.number}",
                        maxLines: 2,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: FontFamily.gilroyMedium,
                          color: greytext,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: PinCodeTextField(
                          appContext: context,
                          length: 6,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          cursorColor: gradient.defoultColor,
                          cursorHeight: 18,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 45,
                            fieldWidth: 45,
                            inactiveColor: gradient.defoultColor,
                            activeColor: gradient.defoultColor,
                            selectedColor: gradient.defoultColor,
                            activeFillColor: Colors.white,
                            inactiveFillColor: WhiteColor,
                            selectedFillColor: WhiteColor,
                            borderWidth: 1,
                          ),
                          animationDuration: Duration(milliseconds: 300),
                          backgroundColor: WhiteColor,
                          enableActiveFill: true,
                          controller: pinPutController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your otp'.tr;
                            }
                            return null;
                          },
                          onCompleted: (v) {
                            print("Completed");
                          },
                          onChanged: (value) {
                            code = value;
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            return true;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn't receive code?".tr,
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyMedium,
                                color: greytext,
                              ),
                            ),
                            enableResend
                                ? InkWell(
                                    onTap: () {
                                      _resendCode();
                                    },
                                    child: Text(
                                      " Resend code".tr,
                                      style: TextStyle(
                                          fontFamily: FontFamily.gilroyBold,
                                          color: gradient.defoultColor,
                                          fontSize: 16),
                                    ),
                                  )
                                : Text(
                                    " $secondsRemaining Seconds".tr,
                                    style: TextStyle(
                                      color: gradient.defoultColor,
                                      fontFamily: FontFamily.gilroyBold,
                                    ),
                                  ),
                            // InkWell(
                            //   onTap: () {
                            //     sendOTP("${widget.number}", "${widget.ccode}");
                            //   },
                            //   child: Container(
                            //     height: 30,
                            //     alignment: Alignment.center,
                            //     child: Text(
                            //       "Resend New Code".tr,
                            //       style: TextStyle(
                            //         color: gradient.defoultColor,
                            //         fontFamily: FontFamily.gilroyBold,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      GestButton(
                        Width: Get.size.width,
                        height: 50,
                        buttoncolor: blueColor,
                        margin: EdgeInsets.only(top: 15, left: 30, right: 30),
                        buttontext: "Verify".tr,
                        style: TextStyle(
                          fontFamily: "Gilroy Bold",
                          color: WhiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        // onclick: () async {
                        //   try {
                        //     PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: ResetPasswordScreen.verifay, smsCode: code,);
                        //     // Sign the user in (or link) with the credential
                        //     await auth.signInWithCredential(credential);
                        //     pinPutController.text = "";
                        //     if (widget.Signup == "signUpScreen") {
                        //       signUpController.setUserApiData("${widget.ccode}");
                        //       showToastMessage(signUpController.signUpMsg);
                        //     }
                        //     if (widget.Signup == "resetScreen") {
                        //       forgetPasswordBottomSheet();
                        //     }
                        //   } catch (e) {
                        //     showToastMessage("Please enter your valid OTP".tr);
                        //   }
                        // },
                        onclick: () async {
                          try {
                            if (widget.msgType == "Firebase") {
                              print("nccdvdvf");
                              PhoneAuthCredential credential =
                                  PhoneAuthProvider.credential(
                                      verificationId:
                                          ResetPasswordScreen.verifay,
                                      smsCode: code);
                              await auth.signInWithCredential(credential);
                              //   print("&&&&&&&&&&&&&&&&&&&&&&&&&&&${verrification}");
                              pinPutController.text = "";
                              if (verrification == "signUpScreen") {
                                signUpController
                                    .setUserApiData("${widget.ccode}");
                                initPlatformState();
                              }
                              if (verrification == "resetScreen") {
                                // Get.to(() => ForgotPassword(ccode: widget.ccode, mobileNo: widget.number));
                                forgetPasswordBottomSheet();
                              }
                            } else {
                              if (widget.otpCode == code) {
                                pinPutController.text = "";
                                if (verrification == "signUpScreen") {
                                  print("35354656");
                                  // signUpController.Register(widget.FullName ?? "", widget.Email ?? "", widget.number ?? "", widget.ccode ?? "", widget.Password ?? "");
                                  signUpController
                                      .setUserApiData("${widget.ccode}");
                                  initPlatformState();
                                }
                                if (verrification == "resetScreen") {
                                  // Get.to(() => ForgotPassword(ccode: widget.ccode, mobileNo: widget.number,));
                                  forgetPasswordBottomSheet();
                                }
                              } else {
                                showToastMessage(
                                    "Please enter your valid OTP".tr);
                              }
                            }
                          } catch (e) {
                            showToastMessage("Please enter your valid OTP".tr);
                          }
                        },
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: WhiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future forgetPasswordBottomSheet() {
    return Get.bottomSheet(
      GetBuilder<LoginController>(builder: (context) {
        return SingleChildScrollView(
          child: Container(
            height: 350,
            width: Get.size.width,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Forgot Password".tr,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: FontFamily.gilroyBold,
                    color: BlackColor,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Divider(
                    color: greytext,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(top: 5, left: 15),
                  child: Text(
                    "Create Your New Password".tr,
                    style: TextStyle(
                      fontFamily: FontFamily.gilroyMedium,
                      color: BlackColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: loginController.newPassword,
                    obscureText: loginController.newShowPassword,
                    cursorColor: BlackColor,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: FontFamily.gilroyMedium,
                      color: BlackColor,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password'.tr;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: greycolor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: greycolor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: greycolor),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          loginController.newShowOfPassword();
                        },
                        child: !loginController.newShowPassword
                            ? Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/showpassowrd.png",
                                  height: 10,
                                  width: 10,
                                  color: greytext,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/HidePassword.png",
                                  height: 10,
                                  width: 10,
                                  color: greytext,
                                ),
                              ),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          "assets/Unlock.png",
                          height: 10,
                          width: 10,
                          color: greytext,
                        ),
                      ),
                      labelText: "Password".tr,
                      labelStyle: TextStyle(
                        color: greytext,
                        fontFamily: FontFamily.gilroyMedium,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: loginController.newConformPassword,
                    obscureText: loginController.conformPassword,
                    cursorColor: BlackColor,
                    style: TextStyle(
                      fontFamily: FontFamily.gilroyMedium,
                      fontSize: 14,
                      color: BlackColor,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password'.tr;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: greycolor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: greycolor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: greycolor),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          loginController.newConformShowOfPassword();
                        },
                        child: !loginController.conformPassword
                            ? Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/showpassowrd.png",
                                  height: 10,
                                  width: 10,
                                  color: greytext,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/HidePassword.png",
                                  height: 10,
                                  width: 10,
                                  color: greytext,
                                ),
                              ),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          "assets/Unlock.png",
                          height: 10,
                          width: 10,
                          color: greytext,
                        ),
                      ),
                      labelText: "Conform Password".tr,
                      labelStyle: TextStyle(
                        color: greytext,
                        fontFamily: FontFamily.gilroyMedium,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestButton(
                  Width: Get.size.width,
                  height: 50,
                  buttoncolor: blueColor,
                  margin: EdgeInsets.only(top: 15, left: 30, right: 30),
                  buttontext: "Continue".tr,
                  style: TextStyle(
                    fontFamily: "Gilroy Bold",
                    color: WhiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  onclick: () {
                    if (loginController.newPassword.text ==
                        loginController.newConformPassword.text) {
                      loginController.setForgetPasswordApi(
                          ccode: widget.ccode, mobile: widget.number);
                    } else {
                      showToastMessage("Please Enter Valid Password".tr);
                    }
                  },
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: bgcolor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
        );
      }),
    );
  }

  void _resendCode() {
    smsTypeController.smsTypeApi().then(
      (smsType) {
        if (smsType["Result"] == "true") {
          print("cscvdxvdcvfcbgbgn");
          if (smsType["otp_auth"] == "No") {
            signUpController.setUserApiData("${widget.ccode}");
          } else {
            if (smsType["SMS_TYPE"] == "Firebase") {
              print("cscvdxvdcvfcbgbgn");
              sendOTP("${widget.number}", "${widget.ccode}");
            } else if (smsType["SMS_TYPE"] == "Msg91") {
              //  msg_otp;
              print("cscvdxvdcvfcbgbgn");
              msgOtpController
                  .msgOtpApi(mobile: "${widget.ccode}${widget.number}")
                  .then(
                (msgOtp) {
                  print("************* ${msgOtp}");
                  if (msgOtp["Result"] == "true") {
                    setState(() {
                      widget.otpCode = msgOtp["otp"].toString();
                    });
                    print("++++++++msgOtp+++++++++++ ${msgOtp["otp"]}");
                  } else {
                    showToastMessage("Invalid mobile number");
                  }
                },
              );
            } else if (smsType["SMS_TYPE"] == "Twilio") {
              print("cscvdxvdcvfcbgbgn");
              twilioOtpController
                  .twilioOtpApi(mobile: "${widget.ccode}${widget.number}")
                  .then(
                (twilioOtp) {
                  print("---------- $twilioOtp");
                  if (twilioOtp["Result"] == "true") {
                    setState(() {
                      widget.otpCode = twilioOtp["otp"].toString();
                    });
                    print("++++++++twilioOtp+++++++++++ ${twilioOtp["otp"]}");
                  } else {
                    showToastMessage("Invalid mobile number".tr);
                  }
                },
              );
            } else {
              showToastMessage("Invalid mobile number".tr);
            }
          }
        }
      },
    );
    setState(() {
      secondsRemaining = 30;
      enableResend = false;
      startTimer();
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          enableResend = true;
          t.cancel(); // Cancel timer when done
        }
      });
    });
  }
}
