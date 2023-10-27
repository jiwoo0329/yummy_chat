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
        return macos;
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
    apiKey: 'AIzaSyACMKUihRLuqJ9t3RO4PnULMPABwoI0RRk',
    appId: '1:835485449092:web:dca193442201337b5cbbd1',
    messagingSenderId: '835485449092',
    projectId: 'yummy-chat-app-c622c',
    authDomain: 'yummy-chat-app-c622c.firebaseapp.com',
    storageBucket: 'yummy-chat-app-c622c.appspot.com',
    measurementId: 'G-R3XNJND3C2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCj0fCJyaGcXlFQZmghGXyEHEeeKUxtlbY',
    appId: '1:835485449092:android:3531e33accd46fde5cbbd1',
    messagingSenderId: '835485449092',
    projectId: 'yummy-chat-app-c622c',
    storageBucket: 'yummy-chat-app-c622c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAJPB_GZfeipGofP852UZq-sX6pU2yD2TI',
    appId: '1:835485449092:ios:2b40b824468c2bc15cbbd1',
    messagingSenderId: '835485449092',
    projectId: 'yummy-chat-app-c622c',
    storageBucket: 'yummy-chat-app-c622c.appspot.com',
    iosBundleId: 'com.example.yummyChat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAJPB_GZfeipGofP852UZq-sX6pU2yD2TI',
    appId: '1:835485449092:ios:d39146956479c20e5cbbd1',
    messagingSenderId: '835485449092',
    projectId: 'yummy-chat-app-c622c',
    storageBucket: 'yummy-chat-app-c622c.appspot.com',
    iosBundleId: 'com.example.yummyChat.RunnerTests',
  );
}
