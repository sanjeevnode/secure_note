import 'package:flutter/material.dart';
import 'package:secure_note/src/src.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key, this.onIndexChanged, this.onSubmit});
  final void Function(int)? onIndexChanged;
  final void Function(AuthEntity)? onSubmit;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  int currentIndex = AuthConstants.loginIndex;
  void onIndexChanged(int index) {
    currentIndex = index;
    emailController.clear();
    passwordController.clear();
    usernameController.clear();
    _formKey.currentState?.reset();
    setState(() {});
    widget.onIndexChanged?.call(index);
  }

  void onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final authEntity = AuthEntity(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      username: currentIndex == AuthConstants.registerIndex
          ? usernameController.text.trim()
          : null,
    );
    widget.onSubmit?.call(authEntity);
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
        child: Form(
          key: _formKey,
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
                    hintText: AuthConstants.usernameHint,
                    labelText: AuthConstants.usernameLabel,
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AuthConstants.usernameRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
              ],

              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: AuthConstants.emailHint,
                  labelText: AuthConstants.emailLabel,
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AuthConstants.emailRequired;
                  }
                  if (!value.contains('@')) {
                    return AuthConstants.emailInvalid;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: AuthConstants.passwordHint,
                  labelText: AuthConstants.passwordLabel,
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AuthConstants.passwordRequired;
                  }
                  if (value.length < 6) {
                    return AuthConstants.passwordMinLength;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: GradientButton(
                  label: currentIndex == AuthConstants.loginIndex
                      ? AuthConstants.loginText
                      : AuthConstants.createAccountText,
                  onSubmit: onSubmit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
