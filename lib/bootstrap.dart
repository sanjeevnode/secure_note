import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:secure_note/src/src.dart';

import 'firebase_options.dart';

Future<void> bootstrap() async {
  // Initialize Flutter bindings
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Preserve the native splash screen until the app is ready
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Setup dependencies and initialize Firebase
  await setupDependencies();

  FlutterNativeSplash.remove();

  runApp(const App());
}
