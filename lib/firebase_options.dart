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
    apiKey: 'AIzaSyAPkGWMsusB-iGboQYEN9z57NzV9K67mms',
    appId: '1:1074027799269:web:4413f36dc5c353066cea0c',
    messagingSenderId: '1074027799269',
    projectId: 'flt-sanal',
    authDomain: 'flt-sanal.firebaseapp.com',
    storageBucket: 'flt-sanal.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA7OGL2hZvjYYih7wiKnvLnFPFCf99ek44',
    appId: '1:1074027799269:android:a150601d6fc2594d6cea0c',
    messagingSenderId: '1074027799269',
    projectId: 'flt-sanal',
    storageBucket: 'flt-sanal.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBcRqNZF2Z3ld23aestnQ_ImdcLlHP0LR0',
    appId: '1:1074027799269:ios:eca52ad931e624a86cea0c',
    messagingSenderId: '1074027799269',
    projectId: 'flt-sanal',
    storageBucket: 'flt-sanal.appspot.com',
    iosClientId: '1074027799269-9610u82isa6d2b5anop760t8l0sc17h7.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterSanalLira',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBcRqNZF2Z3ld23aestnQ_ImdcLlHP0LR0',
    appId: '1:1074027799269:ios:eca52ad931e624a86cea0c',
    messagingSenderId: '1074027799269',
    projectId: 'flt-sanal',
    storageBucket: 'flt-sanal.appspot.com',
    iosClientId: '1074027799269-9610u82isa6d2b5anop760t8l0sc17h7.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterSanalLira',
  );
}
