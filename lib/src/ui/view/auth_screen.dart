import 'package:flutter/material.dart';
import 'package:secure_note/src/src.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Auth Screen", style: AppTextStyle.text2xlBold)),
    );
  }
}
