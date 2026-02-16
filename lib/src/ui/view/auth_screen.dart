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
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 1200,
              maxHeight: getHeight(context, 100),
            ),
            width: double.infinity,
            color: Colors.pink,
            child: SingleChildScrollView(
              child: Column(
                children: [Text("Welcome", style: AppTextStyle.displayH1)],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
