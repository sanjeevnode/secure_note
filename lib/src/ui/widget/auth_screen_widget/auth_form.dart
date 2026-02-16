import 'package:flutter/material.dart';
import 'package:secure_note/src/src.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  int currentIndex = AuthConstants.loginIndex;
  void onIndexChanged(int index) {
    currentIndex = index;
    emailController.clear();
    passwordController.clear();
    usernameController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 512),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppConstants.appBorderRadius),
          boxShadow: const [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchWidget(
              cuurrentIndex: currentIndex,
              onIndexChanged: onIndexChanged,
            ),
            const SizedBox(height: 32),

            if (currentIndex == AuthConstants.registerIndex) ...[
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  hintText: "Choose a username",
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 24),
            ],

            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "your@email.com",
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: "********",
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline),
              ),
              obscureText: true,
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  currentIndex == AuthConstants.loginIndex
                      ? AuthConstants.loginText
                      : AuthConstants.registerText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
