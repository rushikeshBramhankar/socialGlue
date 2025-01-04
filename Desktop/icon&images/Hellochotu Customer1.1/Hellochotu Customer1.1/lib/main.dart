// ignore_for_file: prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, avoid_print, deprecated_member_use, unnecessary_string_escapes

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hellochotu/Api/data_store.dart';
import 'package:hellochotu/helpar/routes_helper.dart';
import 'package:hellochotu/localstring.dart';
import 'package:hellochotu/utils/cart_item.dart';
import 'package:hellochotu/utils/cartitem_adapter.dart';
import 'firebase_options.dart';
import 'helpar/get_di.dart' as di;
import 'dart:io' show Platform;

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());
  await Hive.deleteBoxFromDisk('cart');
  await Hive.openBox<CartItem>('cart');
  await di.init();
  // await Firebase.initializeApp(options: Platform.isAndroid ? FirebaseOptions(
  //   apiKey: 'AIzaSyC_DvOqnmIm5EnA8JCL65FaQTJBftFaU7g',
  //   appId: '1:324152946798:android:d37d3bc56be6924815f67f',
  //   messagingSenderId: '324152946798',
  //   projectId: 'studio-67236',
  //   storageBucket: 'studio-67236.appspot.com',
  // ) :
  // FirebaseOptions(
  //   apiKey: 'YOUR_IOS_API_KEY',
  //   appId: 'YOUR_IOS_APP_ID',
  //   messagingSenderId: 'YOUR_IOS_MESSAGING_SENDER_ID',
  //   projectId: 'YOUR_IOS_PROJECT_ID',
  //   storageBucket: 'YOUR_IOS_STORAGE_BUCKET',
  // )
  // );
  // await _generateAndroidManifest();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Gilroy",
        useMaterial3: false,
      ),
      translations: LocaleString(),
      locale: getData.read("lan2") != null
          ? Locale(getData.read("lan2"), getData.read("lan1"))
          : Locale('en_US', 'en_US'),
      initialRoute: Routes.initial,
      getPages: getPages,
    ),
  );
}

// Future<void> _generateAndroidManifest() async {
//   // Load the original AndroidManifest.xml file
//   final manifestXml =
//       await rootBundle.loadString('android/app/src/main/AndroidManifest.xml');

//   // Replace the placeholder value with the actual value of MY_VARIABLE
//   final generatedXml =
//       manifestXml.replaceAll('\$\{googleKey\}', Config.googleKey);

//   // Write the modified file to the expected location
//   final manifestFile = File('android/app/src/main/AndroidManifest.xml');
//   await manifestFile.writeAsString(generatedXml);
// }
