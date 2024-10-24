// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyDvbkYwDtauZ07Vs-mL6JeBvJXT68U-6vg',
    appId: '1:610656781264:web:199d557b0a1fef5fd96fd5',
    messagingSenderId: '610656781264',
    projectId: 'tennis-app-b3abd',
    authDomain: 'tennis-app-b3abd.firebaseapp.com',
    storageBucket: 'tennis-app-b3abd.appspot.com',
    measurementId: 'G-ND1HXDWZG4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDbRByjwpd33Qd2g7uZcH_Lfz1lbfcF894',
    appId: '1:610656781264:android:941606de7d0126e1d96fd5',
    messagingSenderId: '610656781264',
    projectId: 'tennis-app-b3abd',
    storageBucket: 'tennis-app-b3abd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAVkv3zdZJEkmNlI_6bnYsvVviPyH10Kng',
    appId: '1:610656781264:ios:d7b04d8edda43a30d96fd5',
    messagingSenderId: '610656781264',
    projectId: 'tennis-app-b3abd',
    storageBucket: 'tennis-app-b3abd.appspot.com',
    iosBundleId: 'com.example.weatherApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAVkv3zdZJEkmNlI_6bnYsvVviPyH10Kng',
    appId: '1:610656781264:ios:d7b04d8edda43a30d96fd5',
    messagingSenderId: '610656781264',
    projectId: 'tennis-app-b3abd',
    storageBucket: 'tennis-app-b3abd.appspot.com',
    iosBundleId: 'com.example.weatherApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDvbkYwDtauZ07Vs-mL6JeBvJXT68U-6vg',
    appId: '1:610656781264:web:dac61a3d8b503aabd96fd5',
    messagingSenderId: '610656781264',
    projectId: 'tennis-app-b3abd',
    authDomain: 'tennis-app-b3abd.firebaseapp.com',
    storageBucket: 'tennis-app-b3abd.appspot.com',
    measurementId: 'G-TZDQ9KREM3',
  );
}
