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
    apiKey: 'AIzaSyAojCgbUXFSQLzyaN9ipNb2ZjjtwaK0pUk',
    appId: '1:608493641447:web:3989ebfbb4864cea174c42',
    messagingSenderId: '608493641447',
    projectId: 'lingopandaround2',
    authDomain: 'lingopandaround2.firebaseapp.com',
    storageBucket: 'lingopandaround2.appspot.com',
    measurementId: 'G-KT6Q7BYH4Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCg9Q80QY2Or0TmLCc8pJrpUAqr_afdDNs',
    appId: '1:608493641447:android:33945887c648bfa0174c42',
    messagingSenderId: '608493641447',
    projectId: 'lingopandaround2',
    storageBucket: 'lingopandaround2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAK1FUSgRMO40MyRyXhabCdD-Rgf9l7J3I',
    appId: '1:608493641447:ios:6295cb4a1a61aa33174c42',
    messagingSenderId: '608493641447',
    projectId: 'lingopandaround2',
    storageBucket: 'lingopandaround2.appspot.com',
    iosBundleId: 'com.example.lingopandaEcomApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAK1FUSgRMO40MyRyXhabCdD-Rgf9l7J3I',
    appId: '1:608493641447:ios:6295cb4a1a61aa33174c42',
    messagingSenderId: '608493641447',
    projectId: 'lingopandaround2',
    storageBucket: 'lingopandaround2.appspot.com',
    iosBundleId: 'com.example.lingopandaEcomApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAojCgbUXFSQLzyaN9ipNb2ZjjtwaK0pUk',
    appId: '1:608493641447:web:92ffbe14a71c142b174c42',
    messagingSenderId: '608493641447',
    projectId: 'lingopandaround2',
    authDomain: 'lingopandaround2.firebaseapp.com',
    storageBucket: 'lingopandaround2.appspot.com',
    measurementId: 'G-ZZ05ST5TB0',
  );
}
