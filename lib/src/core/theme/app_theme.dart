import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get standard {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: false,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: FadeForwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
}

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}

class CustomBehaviour extends StatelessWidget {
  const CustomBehaviour({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: Stack(
        children: [
          ScrollConfiguration(
            behavior: const ScrollBehaviorModified(),
            child: child,
          ),
        ],
      ),
    );
  }
}
