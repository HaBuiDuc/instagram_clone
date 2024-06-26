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
    apiKey: 'AIzaSyASkCwDQfK3b_amivvWSFJ52IacUVMZoow',
    appId: '1:1020327443282:web:995242b4b673739baf188b',
    messagingSenderId: '1020327443282',
    projectId: 'instagram-clone-a958d',
    authDomain: 'instagram-clone-a958d.firebaseapp.com',
    storageBucket: 'instagram-clone-a958d.appspot.com',
    measurementId: 'G-NZKJ5DV407',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDphYQb9iIfQ-Sc2IkHhLJaBefKUARFTfo',
    appId: '1:1020327443282:android:6ca022aa5156d0d1af188b',
    messagingSenderId: '1020327443282',
    projectId: 'instagram-clone-a958d',
    storageBucket: 'instagram-clone-a958d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBjd7vkmjiGfEeb7h0vl9RHQ1zmlYFeiLU',
    appId: '1:1020327443282:ios:11750af178d98fb7af188b',
    messagingSenderId: '1020327443282',
    projectId: 'instagram-clone-a958d',
    storageBucket: 'instagram-clone-a958d.appspot.com',
    iosBundleId: 'com.buiducha.instagramClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBjd7vkmjiGfEeb7h0vl9RHQ1zmlYFeiLU',
    appId: '1:1020327443282:ios:11750af178d98fb7af188b',
    messagingSenderId: '1020327443282',
    projectId: 'instagram-clone-a958d',
    storageBucket: 'instagram-clone-a958d.appspot.com',
    iosBundleId: 'com.buiducha.instagramClone',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyASkCwDQfK3b_amivvWSFJ52IacUVMZoow',
    appId: '1:1020327443282:web:4e8981c259d98d7daf188b',
    messagingSenderId: '1020327443282',
    projectId: 'instagram-clone-a958d',
    authDomain: 'instagram-clone-a958d.firebaseapp.com',
    storageBucket: 'instagram-clone-a958d.appspot.com',
    measurementId: 'G-E3CT89P5MW',
  );

}