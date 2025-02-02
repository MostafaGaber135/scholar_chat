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
    apiKey: 'AIzaSyAnPsFDJu44xpBbocp5zKVdv3S9LJGm92g',
    appId: '1:451218447034:web:1ef86efe3985fa0cba8083',
    messagingSenderId: '451218447034',
    projectId: 'chat-app-bc7ef',
    authDomain: 'chat-app-bc7ef.firebaseapp.com',
    storageBucket: 'chat-app-bc7ef.appspot.com',
    measurementId: 'G-HLCK1K0QNR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD8rnYVKYYA73PygR9rIeb6Bf3plubGUwg',
    appId: '1:451218447034:android:4b453f82915c97ffba8083',
    messagingSenderId: '451218447034',
    projectId: 'chat-app-bc7ef',
    storageBucket: 'chat-app-bc7ef.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC1SKfimW5k1DtACgFJAn6uIXdJk8mRVvw',
    appId: '1:451218447034:ios:41964a0ea8553013ba8083',
    messagingSenderId: '451218447034',
    projectId: 'chat-app-bc7ef',
    storageBucket: 'chat-app-bc7ef.appspot.com',
    iosBundleId: 'com.example.scholarChat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC1SKfimW5k1DtACgFJAn6uIXdJk8mRVvw',
    appId: '1:451218447034:ios:41964a0ea8553013ba8083',
    messagingSenderId: '451218447034',
    projectId: 'chat-app-bc7ef',
    storageBucket: 'chat-app-bc7ef.appspot.com',
    iosBundleId: 'com.example.scholarChat',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAnPsFDJu44xpBbocp5zKVdv3S9LJGm92g',
    appId: '1:451218447034:web:0ed860b18ae228f6ba8083',
    messagingSenderId: '451218447034',
    projectId: 'chat-app-bc7ef',
    authDomain: 'chat-app-bc7ef.firebaseapp.com',
    storageBucket: 'chat-app-bc7ef.appspot.com',
    measurementId: 'G-QMRXW3EQPZ',
  );
}
