// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:hellochotu/Api/config.dart';
import 'package:hellochotu/Api/data_store.dart';
import 'package:hellochotu/controller/catdetails_controller.dart';
import 'package:hellochotu/helpar/routes_helper.dart';
import 'package:hellochotu/utils/Custom_widget.dart';

import '../screen/bottombarpro_screen.dart';

class AddLocationController extends GetxController implements GetxService {
  TextEditingController completeAddress = TextEditingController();
  TextEditingController landMark = TextEditingController();
  TextEditingController reach = TextEditingController();
  TextEditingController homeAddress = TextEditingController();

  CatDetailsController catDetailsController = Get.find();

  var lat;
  var long;
  var address;
  getCurrentLatAndLong(double latitude, double longitude) {
    lat = latitude;
    long = longitude;
    Get.toNamed(Routes.deliveryaddress2);
    update();
  }

  addAddressApi() async {
    try {
      Map map = {
        "uid": getData.read("UserLogin")["id"],
        "address": completeAddress.text,
        "lats": lat.toString(),
        "longs": long.toString(),
        "a_type": homeAddress.text,
        "landmark": landMark.text,
        "r_instruction": reach.text != "" ? reach.text : "",
      };
      Uri uri = Uri.parse(Config.path + Config.addAddress);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result["Result"] == "true") {
          showToastMessage(result["ResponseMsg"]);
          catDetailsController.changeIndex(2);
          Get.offAll(BottombarProScreen());
          completeAddress.text = "";
          landMark.text = "";
          reach.text = "";
          homeAddress.text = "";
        } else {
          showToastMessage(result["ResponseMsg"]);
        }
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
