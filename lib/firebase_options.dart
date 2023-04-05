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
    apiKey: 'AIzaSyATFI_BZtgesTANkYbTkXbEApN9lexUqPg',
    appId: '1:618063914642:web:2fdf5f297dbeccb57ae84b',
    messagingSenderId: '618063914642',
    projectId: 'author-registration-ed944',
    authDomain: 'author-registration-ed944.firebaseapp.com',
    storageBucket: 'author-registration-ed944.appspot.com',
    measurementId: 'G-LSNJ2M6FZV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBlZb9XrL6NiQ48fP2gnSiYhDkyxia3bLI',
    appId: '1:618063914642:android:614b9b814844fc807ae84b',
    messagingSenderId: '618063914642',
    projectId: 'author-registration-ed944',
    storageBucket: 'author-registration-ed944.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB704gDIAu9lPpa5Ih4x7P8sukTO14EjjQ',
    appId: '1:618063914642:ios:f9f683c9767f5db77ae84b',
    messagingSenderId: '618063914642',
    projectId: 'author-registration-ed944',
    storageBucket: 'author-registration-ed944.appspot.com',
    iosClientId: '618063914642-h659qdi4j5rbs87v14guv9raitj7ffc7.apps.googleusercontent.com',
    iosBundleId: 'com.example.authorApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB704gDIAu9lPpa5Ih4x7P8sukTO14EjjQ',
    appId: '1:618063914642:ios:f9f683c9767f5db77ae84b',
    messagingSenderId: '618063914642',
    projectId: 'author-registration-ed944',
    storageBucket: 'author-registration-ed944.appspot.com',
    iosClientId: '618063914642-h659qdi4j5rbs87v14guv9raitj7ffc7.apps.googleusercontent.com',
    iosBundleId: 'com.example.authorApp',
  );
}
