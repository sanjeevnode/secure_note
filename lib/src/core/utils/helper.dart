import 'package:flutter/material.dart';

/// Calculates responsive height based on percentage of screen height
double getHeight(BuildContext context, double height) {
  return MediaQuery.of(context).size.height * (height / 100);
}

/// Calculates responsive width based on percentage of screen width
double getWidth(BuildContext context, double width) {
  return MediaQuery.of(context).size.width * (width / 100);
}
