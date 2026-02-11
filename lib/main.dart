import 'dart:async';
import 'package:flutter/material.dart';
import 'package:secure_note/bootstrap.dart';

Future<void> main() async {
  runZonedGuarded(() {
    bootstrap();
  }, (error, stackTrace) {});

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };
}
