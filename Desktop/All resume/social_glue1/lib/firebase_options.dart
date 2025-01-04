// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAWpeMGNGP-6p_ZB1hw8cR0UD3cNmJGiNw',
    appId: '1:43625461858:web:1979c14c860a5e6ab3b93b',
    messagingSenderId: '43625461858',
    projectId: 'socialglue-cb8cc',
    authDomain: 'socialglue-cb8cc.firebaseapp.com',
    storageBucket: 'socialglue-cb8cc.firebasestorage.app',
    measurementId: 'G-JFH1MN6H69',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDLZja3IkjT4t9LZnn--dQTWM69d0RRnOk',
    appId: '1:43625461858:android:d767ae9c2205a593b3b93b',
    messagingSenderId: '43625461858',
    projectId: 'socialglue-cb8cc',
    storageBucket: 'socialglue-cb8cc.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB5oY_eooZlecFmS5vHH5UEiLkn0yM6A8g',
    appId: '1:43625461858:ios:c1483ca9e4b46e56b3b93b',
    messagingSenderId: '43625461858',
    projectId: 'socialglue-cb8cc',
    storageBucket: 'socialglue-cb8cc.firebasestorage.app',
    iosBundleId: 'com.example.socialGlue1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB5oY_eooZlecFmS5vHH5UEiLkn0yM6A8g',
    appId: '1:43625461858:ios:c1483ca9e4b46e56b3b93b',
    messagingSenderId: '43625461858',
    projectId: 'socialglue-cb8cc',
    storageBucket: 'socialglue-cb8cc.firebasestorage.app',
    iosBundleId: 'com.example.socialGlue1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAWpeMGNGP-6p_ZB1hw8cR0UD3cNmJGiNw',
    appId: '1:43625461858:web:4ebef21f707839c3b3b93b',
    messagingSenderId: '43625461858',
    projectId: 'socialglue-cb8cc',
    authDomain: 'socialglue-cb8cc.firebaseapp.com',
    storageBucket: 'socialglue-cb8cc.firebasestorage.app',
    measurementId: 'G-NCTPBBYXEW',
  );
}
