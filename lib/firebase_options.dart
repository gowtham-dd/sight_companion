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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: '',
    appId: '1:287967245163:web:70b8b87a9b4af0f263522e',
    messagingSenderId: '287967245163',
    projectId: 'diabilitylogin',
    authDomain: 'diabilitylogin.firebaseapp.com',
    storageBucket: 'diabilitylogin.appspot.com',
    measurementId: 'G-NY61EKZH2S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: '',
    appId: '1:287967245163:android:edced155ecd0f1c263522e',
    messagingSenderId: '287967245163',
    projectId: 'diabilitylogin',
    storageBucket: 'diabilitylogin.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '',
    appId: '1:287967245163:ios:aa8b244750f17f2d63522e',
    messagingSenderId: '287967245163',
    projectId: 'diabilitylogin',
    storageBucket: 'diabilitylogin.appspot.com',
    iosBundleId: 'com.example.sightCompanion',
  );
}
