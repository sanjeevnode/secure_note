import 'package:flutter/material.dart';
import 'package:secure_note/src/src.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoadingWrapper(
      isLoading: true,
      child: AppPageLayout(child: Center(child: AppIcon())),
    );
  }
}
