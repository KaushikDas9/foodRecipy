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
    apiKey: 'AIzaSyAjwA0xRW-SZiOHhUp9qx9oi4iGUedKFMQ',
    appId: '1:717938910191:web:442dc1031f3abc750ccc1a',
    messagingSenderId: '717938910191',
    projectId: 'foodrecipibykd9',
    authDomain: 'foodrecipibykd9.firebaseapp.com',
    databaseURL:
        'https://foodrecipibykd9-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'foodrecipibykd9.appspot.com',
    measurementId: 'G-XTCBSZ8ZPY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBmf_rEfiulbykGJ-cMMG_YPgoIJA4RcLQ',
    appId: '1:717938910191:android:e91d85520f2316cf0ccc1a',
    messagingSenderId: '717938910191',
    projectId: 'foodrecipibykd9',
    databaseURL:
        'https://foodrecipibykd9-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'foodrecipibykd9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDRiQJA35QvZZaoGil4pqXX25s5mSJ0H0U',
    appId: '1:717938910191:ios:92d70d03acf990f60ccc1a',
    messagingSenderId: '717938910191',
    projectId: 'foodrecipibykd9',
    databaseURL:
        'https://foodrecipibykd9-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'foodrecipibykd9.appspot.com',
    iosBundleId: 'com.example.untitled',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDRiQJA35QvZZaoGil4pqXX25s5mSJ0H0U',
    appId: '1:717938910191:ios:4352e948ef65cb9a0ccc1a',
    messagingSenderId: '717938910191',
    projectId: 'foodrecipibykd9',
    databaseURL:
        'https://foodrecipibykd9-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'foodrecipibykd9.appspot.com',
    iosBundleId: 'com.example.untitled.RunnerTests',
  );
}
