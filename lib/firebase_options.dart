// Generated via flutterfire CLI against Firebase project "zim-edu-bridge".
// To regenerate for all platforms, run: flutterfire configure --project=zim-edu-bridge

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        return linux;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not configured for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyARjkDNmY3xkZl8V-11mVQ75Fz5rqDGEY0',
    appId: '1:867646528840:web:09c427ea409090da78277d',
    messagingSenderId: '867646528840',
    projectId: 'zim-edu-bridge',
    authDomain: 'zim-edu-bridge.firebaseapp.com',
    storageBucket: 'zim-edu-bridge.firebasestorage.app',
    measurementId: 'G-2HPQN74V7M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9aazY4oUSu-CpMzT6WNofnpOkmjG8XXA',
    appId: '1:867646528840:android:ebcb52ae1906d0f078277d',
    messagingSenderId: '867646528840',
    projectId: 'zim-edu-bridge',
    storageBucket: 'zim-edu-bridge.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCYKsXTuT8HK3Pesb_y5Xj4WfpYgs9qSzw',
    appId: '1:867646528840:ios:4b0d6f9e5fa63a8078277d',
    messagingSenderId: '867646528840',
    projectId: 'zim-edu-bridge',
    storageBucket: 'zim-edu-bridge.firebasestorage.app',
    iosBundleId: 'com.zimHeritageApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCYKsXTuT8HK3Pesb_y5Xj4WfpYgs9qSzw',
    appId: '1:867646528840:ios:4b0d6f9e5fa63a8078277d',
    messagingSenderId: '867646528840',
    projectId: 'zim-edu-bridge',
    storageBucket: 'zim-edu-bridge.firebasestorage.app',
    iosBundleId: 'com.zimHeritageApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyARjkDNmY3xkZl8V-11mVQ75Fz5rqDGEY0',
    appId: '1:867646528840:web:09c427ea409090da78277d',
    messagingSenderId: '867646528840',
    projectId: 'zim-edu-bridge',
    storageBucket: 'zim-edu-bridge.firebasestorage.app',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'AIzaSyARjkDNmY3xkZl8V-11mVQ75Fz5rqDGEY0',
    appId: '1:867646528840:web:09c427ea409090da78277d',
    messagingSenderId: '867646528840',
    projectId: 'zim-edu-bridge',
    storageBucket: 'zim-edu-bridge.firebasestorage.app',
  );
}
