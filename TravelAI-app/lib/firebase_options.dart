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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBySmG15RJdcAqirZiclkB880r4oJ0gMGI',
    appId: '1:989360351367:android:24dd6488c3a4473b97f022',
    messagingSenderId: '989360351367',
    projectId: 'smart-travel-assistance',
    storageBucket: 'smart-travel-assistance.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'API_KEY',
    appId: '1:989360351367:ios:3019431a12b5ee2197f022',
    messagingSenderId: '989360351367',
    projectId: 'smart-travel-assistance',
    storageBucket: 'smart-travel-assistance.appspot.com',
    androidClientId: '989360351367-h8co71cguqe05kgckhrl4gjn91ocvtgc.apps.googleusercontent.com',
    iosClientId: '989360351367-fdm3ddl3nqq9nedsfbivfgqp4m5425gr.apps.googleusercontent.com',
    iosBundleId: 'com.example.smartTravelAssistant',
  );
}