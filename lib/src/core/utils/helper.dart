import 'package:flutter/material.dart';

/// Calculates responsive height based on percentage of screen height
double getHeight(BuildContext context, double height) {
  return MediaQuery.of(context).size.height * (height / 100);
}

/// Calculates responsive width based on percentage of screen width
double getWidth(BuildContext context, double width) {
  return MediaQuery.of(context).size.width * (width / 100);
}

String getInitials(String? input) {
  if (input == null || input.trim().isEmpty) return "";

  // Split by spaces and remove empty items
  final parts = input.trim().split(RegExp(r'\s+'));

  // If only one word → return first letter capitalized
  if (parts.length == 1) {
    return parts.first[0].toUpperCase();
  }

  // Take first 2 words → first character of each → capitalize
  final first = parts[0][0].toUpperCase();
  final second = parts[1][0].toUpperCase();

  return "$first$second";
}
