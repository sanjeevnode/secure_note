import 'package:flutter/material.dart';
import 'package:secure_note/src/src.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AppView();
  }
}

class _AppView extends StatefulWidget {
  const _AppView();

  @override
  State<_AppView> createState() => __AppViewState();
}

class __AppViewState extends State<_AppView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.standard,
      title: 'Secure Note',
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return CustomBehaviour(child: child!);
      },
      home: const AuthScreen(),
    );
  }
}
