// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:hellochotu/Api/data_store.dart';
import 'package:hellochotu/controller/signup_controller.dart';
import 'package:hellochotu/model/fontfamily_model.dart';
import 'package:hellochotu/screen/loginAndsignup/login_screen.dart';
import 'package:hellochotu/screen/loginAndsignup/otp_screen.dart';
import 'package:hellochotu/screen/loginAndsignup/resetpassword_screen.dart';
import 'package:hellochotu/utils/Colors.dart';
import 'package:hellochotu/utils/Custom_widget.dart';

import '../../controller/msg_otp_controller.dart';
import '../../controller/sms_type_controller.dart';
import '../../controller/twilio_otp_controller.dart';
import '../../helpar/routes_helper.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpController signUpController = Get.find();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String cuntryCode = "";
  SmsTypeController smsTypeController = Get.put(SmsTypeController());
  MsgOtpController msgOtpController = Get.put(MsgOtpController());
  TwilioOtpController twilioOtpController = Get.put(TwilioOtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Container(
        height: Get.height,
        color: transparent,
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
                        height: Get.height * 0.15,
                      ),
                      Text(
                        "Create Your Account".tr,
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
                        "Setting up an account".tr,
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
                    width: Get.size.width * 0.6,
                    child: Image.asset(
                      "assets/signupImage.png",
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
              bottom: 0,
              top: Get.height * 0.32,
              child: Form(
                key: _formKey,
                child: Container(
                  width: Get.width * 0.9,
                  height: Get.height,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   "Sign Up !".tr,
                        //   style: TextStyle(
                        //     color: BlackColor,
                        //     fontFamily: "Gilroy Bold",
                        //     fontSize: 22,
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: Get.height * 0.005,
                        // ),
                        // Text(
                        //   "Create an account to continue.".tr,
                        //   style: TextStyle(
                        //     color: BlackColor,
                        //     fontFamily: "Gilroy Medium",
                        //     fontSize: 16,
                        //   ),
                        // ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            "Full Name".tr,
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyBold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          controller: signUpController.name,
                          cursorColor: BlackColor,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: BlackColor,
                          ),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                "assets/user.png",
                                height: 22,
                                width: 22,
                                color: greytext,
                              ),
                            ),
                            labelText: "Full Name".tr,
                            labelStyle: TextStyle(
                              color: greytext,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name'.tr;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            "Email Address".tr,
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyBold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          controller: signUpController.email,
                          cursorColor: BlackColor,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: BlackColor,
                          ),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                "assets/email.png",
                                height: 25,
                                width: 25,
                                color: greytext,
                              ),
                            ),
                            labelText: "Email Address".tr,
                            labelStyle: TextStyle(
                              color: greytext,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email'.tr;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            "Mobile Number".tr,
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyBold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        IntlPhoneField(
                          keyboardType: TextInputType.number,
                          cursorColor: BlackColor,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: signUpController.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          disableLengthCheck: true,
                          dropdownIcon: Icon(
                            Icons.arrow_drop_down,
                            color: greytext,
                          ),
                          dropdownTextStyle: TextStyle(
                            color: greytext,
                          ),
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: BlackColor,
                          ),
                          onChanged: (value) {
                            cuntryCode = value.countryCode;
                          },
                          initialCountryCode: 'IN',
                          onCountryChanged: (value) {
                            signUpController.number.text = '';
                          },
                          decoration: InputDecoration(
                            helperText: null,
                            labelText: "Mobile Number".tr,
                            labelStyle: TextStyle(
                              color: greytext,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (p0) {
                            if (p0!.completeNumber.isEmpty) {
                              return 'Please enter your number'.tr;
                            } else {}
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            "Password".tr,
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyBold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        GetBuilder<SignUpController>(builder: (context) {
                          return TextFormField(
                            controller: signUpController.password,
                            obscureText: signUpController.showPassword,
                            cursorColor: BlackColor,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: BlackColor,
                            ),
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  signUpController.showOfPassword();
                                },
                                child: !signUpController.showPassword
                                    ? Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Image.asset(
                                          "assets/showpassowrd.png",
                                          height: 25,
                                          width: 25,
                                          color: greytext,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Image.asset(
                                          "assets/HidePassword.png",
                                          height: 25,
                                          width: 25,
                                          color: greytext,
                                        ),
                                      ),
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/Unlock.png",
                                  height: 25,
                                  width: 25,
                                  color: greytext,
                                ),
                              ),
                              labelText: "Password".tr,
                              labelStyle: TextStyle(
                                color: greytext,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password'.tr;
                              }
                              return null;
                            },
                          );
                        }),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            "Referral code".tr,
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyBold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          controller: signUpController.referralCode,
                          cursorColor: BlackColor,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: BlackColor,
                          ),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            labelText: "Referral code (optional)".tr,
                            labelStyle: TextStyle(
                              color: greytext,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GetBuilder<SignUpController>(builder: (context) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Transform.scale(
                                scale: 1,
                                child: Checkbox(
                                  value: signUpController.chack,
                                  side: const BorderSide(
                                      color: Color(0xffC5CAD4)),
                                  activeColor: blueColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  onChanged: (newbool) async {
                                    signUpController
                                        .checkTermsAndCondition(newbool);
                                    save('Remember', true);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "By creating an account,you agree to our"
                                        .tr,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: greytext,
                                      fontFamily: FontFamily.gilroyMedium,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    "Terms and Condition".tr,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: gradient.defoultColor,
                                      fontFamily: FontFamily.gilroyBold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                        GestButton(
                          Width: Get.size.width,
                          height: 50,
                          buttoncolor: blueColor,
                          margin: EdgeInsets.only(top: 15, left: 30, right: 30),
                          buttontext: "Continue".tr,
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyBold,
                            color: WhiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          onclick: () {
                            if ((_formKey.currentState?.validate() ?? false) &&
                                (signUpController.chack == true)) {
                              // signUpController.checkMobileNumber(cuntryCode);
                              signUpController
                                  .checkMobileNumber(cuntryCode)
                                  .then(
                                (value) {
                                  var decodeValue = jsonDecode(value);
                                  if (decodeValue["Result"] == "true") {
                                    smsTypeController.smsTypeApi().then(
                                      (smsType) {
                                        if (smsType["Result"] == "true") {
                                          print("cscvdxvdcvfcbgbgn");
                                          if (smsType["otp_auth"] == "No") {
                                            signUpController
                                                .setUserApiData(cuntryCode);
                                          } else {
                                            if (smsType["SMS_TYPE"] ==
                                                "Firebase") {
                                              print("cscvdxvdcvfcbgbgn");
                                              sendOTP(
                                                  signUpController.number.text,
                                                  cuntryCode);
                                              // Get.to(() =>
                                              //     VerifyAccount(
                                              //       ccode: Country,
                                              //       number: Mobile.text,
                                              //       Email: Email.text,
                                              //       FullName: FullName.text,
                                              //       Password: Password.text,
                                              //       img: base64Image,
                                              //       Signup: "Signup",
                                              //       msgType: smsType["SMS_TYPE"],
                                              //     ));
                                              Get.to(() => OtpScreen(
                                                    ccode: cuntryCode,
                                                    number: signUpController
                                                        .number.text,
                                                    Email: signUpController
                                                        .email.text,
                                                    FullName: signUpController
                                                        .name.text,
                                                    Password: signUpController
                                                        .password.text,
                                                    Signup: "signUpScreen",
                                                    otpCode: "",
                                                    msgType:
                                                        smsType["SMS_TYPE"],
                                                  ));
                                            } else if (smsType["SMS_TYPE"] ==
                                                "Msg91") {
                                              //  msg_otp;
                                              print("cscvdxvdcvfcbgbgn");
                                              msgOtpController
                                                  .msgOtpApi(
                                                      mobile:
                                                          "$cuntryCode${signUpController.number.text}")
                                                  .then(
                                                (msgOtp) {
                                                  print(
                                                      "************* ${msgOtp}");
                                                  if (msgOtp["Result"] ==
                                                      "true") {
                                                    Get.to(() => OtpScreen(
                                                          ccode: cuntryCode,
                                                          number:
                                                              signUpController
                                                                  .number.text,
                                                          Email:
                                                              signUpController
                                                                  .email.text,
                                                          FullName:
                                                              signUpController
                                                                  .name.text,
                                                          Password:
                                                              signUpController
                                                                  .password
                                                                  .text,
                                                          Signup:
                                                              "signUpScreen",
                                                          otpCode: msgOtp["otp"]
                                                              .toString(),
                                                          msgType: smsType[
                                                              "SMS_TYPE"],
                                                        ));
                                                    print(
                                                        "++++++++msgOtp+++++++++++ ${msgOtp["otp"]}");
                                                  } else {
                                                    showToastMessage(
                                                        "Invalid mobile number");
                                                  }
                                                },
                                              );
                                            } else if (smsType["SMS_TYPE"] ==
                                                "Twilio") {
                                              print("cscvdxvdcvfcbgbgn");
                                              twilioOtpController
                                                  .twilioOtpApi(
                                                      mobile:
                                                          "$cuntryCode${signUpController.number.text}")
                                                  .then(
                                                (twilioOtp) {
                                                  print(
                                                      "---------- $twilioOtp");
                                                  if (twilioOtp["Result"] ==
                                                      "true") {
                                                    Get.to(() => OtpScreen(
                                                          ccode: cuntryCode,
                                                          number:
                                                              signUpController
                                                                  .number.text,
                                                          Email:
                                                              signUpController
                                                                  .email.text,
                                                          FullName:
                                                              signUpController
                                                                  .name.text,
                                                          Password:
                                                              signUpController
                                                                  .password
                                                                  .text,
                                                          Signup:
                                                              "signUpScreen",
                                                          otpCode:
                                                              twilioOtp["otp"]
                                                                  .toString(),
                                                          msgType: smsType[
                                                              "SMS_TYPE"],
                                                        ));
                                                    print(
                                                        "++++++++twilioOtp+++++++++++ ${twilioOtp["otp"]}");
                                                  } else {
                                                    showToastMessage(
                                                        "Invalid mobile number"
                                                            .tr);
                                                  }
                                                },
                                              );
                                            } else {
                                              showToastMessage(
                                                  "Invalid mobile number".tr);
                                            }
                                          }
                                        } else {
                                          showToastMessage(
                                              "Invalid mobile number".tr);
                                        }
                                      },
                                    );
                                  } else {
                                    showToastMessage(
                                        decodeValue["ResponseMsg"]);
                                  }
                                },
                              );
                            } else {
                              if (signUpController.chack == false) {
                                showToastMessage(
                                    "Please select Terms and Condition".tr);
                              }
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 45),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?".tr,
                                style: TextStyle(
                                  fontFamily: FontFamily.gilroyMedium,
                                  color: greytext,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(LoginScreen());
                                },
                                child: Text(
                                  "Login".tr,
                                  style: TextStyle(
                                    color: gradient.defoultColor,
                                    fontFamily: FontFamily.gilroyBold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: WhiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
