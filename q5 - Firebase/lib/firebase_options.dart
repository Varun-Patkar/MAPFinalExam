// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBBZGdXGFXJ0TqKIbYQvyQrrL_Dqch16_s',
    appId: '1:813590573544:web:5690be9520d4e3644d345d',
    messagingSenderId: '813590573544',
    projectId: 'final-exam-map',
    authDomain: 'final-exam-map.firebaseapp.com',
    storageBucket: 'final-exam-map.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDybOEYR-oqEZ1InN3Y_QtGSLYT2yONlGE',
    appId: '1:813590573544:android:1484c51564d54c834d345d',
    messagingSenderId: '813590573544',
    projectId: 'final-exam-map',
    storageBucket: 'final-exam-map.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDPN9rq-9ewaEiBi0g4Zt4Ez_AM_5LcBnE',
    appId: '1:813590573544:ios:fe317dd2ddb2fcdf4d345d',
    messagingSenderId: '813590573544',
    projectId: 'final-exam-map',
    storageBucket: 'final-exam-map.appspot.com',
    iosClientId: '813590573544-g5n8m2ud53c95he1vrc46k4aqvt28roa.apps.googleusercontent.com',
    iosBundleId: 'com.example.q5',
  );
}
