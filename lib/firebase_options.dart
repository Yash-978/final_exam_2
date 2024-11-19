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
    apiKey: 'AIzaSyDc8ekFQQV7sWQdD8e5fXzJn9xNSp7iCac',
    appId: '1:901126754967:web:2799997ba859a9d136cfd2',
    messagingSenderId: '901126754967',
    projectId: 'final-exam-2-fb1f2',
    authDomain: 'final-exam-2-fb1f2.firebaseapp.com',
    storageBucket: 'final-exam-2-fb1f2.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC-DeoLgCN5CR6BAHqZ3Q6YZAnU0QiCBqo',
    appId: '1:901126754967:android:e5d760513982102a36cfd2',
    messagingSenderId: '901126754967',
    projectId: 'final-exam-2-fb1f2',
    storageBucket: 'final-exam-2-fb1f2.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-8Xe19FkQ6fLb9arLnCHKbJ-u2L1KRoA',
    appId: '1:901126754967:ios:bf852a7cd965931736cfd2',
    messagingSenderId: '901126754967',
    projectId: 'final-exam-2-fb1f2',
    storageBucket: 'final-exam-2-fb1f2.firebasestorage.app',
    iosBundleId: 'com.example.finalExam2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD-8Xe19FkQ6fLb9arLnCHKbJ-u2L1KRoA',
    appId: '1:901126754967:ios:bf852a7cd965931736cfd2',
    messagingSenderId: '901126754967',
    projectId: 'final-exam-2-fb1f2',
    storageBucket: 'final-exam-2-fb1f2.firebasestorage.app',
    iosBundleId: 'com.example.finalExam2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDc8ekFQQV7sWQdD8e5fXzJn9xNSp7iCac',
    appId: '1:901126754967:web:ffc0c048b6c1e84a36cfd2',
    messagingSenderId: '901126754967',
    projectId: 'final-exam-2-fb1f2',
    authDomain: 'final-exam-2-fb1f2.firebaseapp.com',
    storageBucket: 'final-exam-2-fb1f2.firebasestorage.app',
  );
}
