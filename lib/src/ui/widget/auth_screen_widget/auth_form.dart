import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_note/src/src.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  bool showPassword = false;

  int currentIndex = AuthConstants.loginIndex;
  void onIndexChanged(int index) {
    currentIndex = index;
    emailController.clear();
    passwordController.clear();
    usernameController.clear();
    _formKey.currentState?.reset();
    setState(() {});
  }

  Future<void> onSubmit() async {
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
    if (currentIndex == AuthConstants.registerIndex) {
      await _handleRegister(authEntity);
    } else {
      await _handleLogin(authEntity);
    }
  }

  Future<void> _handleRegister(AuthEntity a) async {
    final authCubit = context.read<AuthCubit>();
    await authCubit.register(
      email: a.email,
      password: a.password,
      username: a.username!,
    );
  }

  Future<void> _handleLogin(AuthEntity a) async {
    final authCubit = context.read<AuthCubit>();
    await authCubit.login(email: a.email, password: a.password);
  }

  void _handleNavigation() {
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouteNames.home,
      (_) => false,
    );
  }

  void _handleListners(Status loginStatus, Status registerStatus) {
    if (currentIndex == AuthConstants.loginIndex) {
      if (loginStatus == Status.success) {
        _handleNavigation();
      } else if (loginStatus == Status.error) {
        Toast.error(AuthConstants.loginError);
      }
    } else {
      if (registerStatus == Status.success) {
        currentIndex = AuthConstants.loginIndex;
        setState(() {});
        Toast.success(AuthConstants.registrationSuccess);
      } else if (registerStatus == Status.error) {
        Toast.error(AuthConstants.registrationError);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthCubitState>(
      listener: (context, state) {
        _handleListners(state.loginStatus, state.registerStatus);
      },
      builder: (context, state) {
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
            child: Shortcuts(
              shortcuts: {
                LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
              },
              child: Actions(
                actions: {
                  ActivateIntent: CallbackAction<ActivateIntent>(
                    onInvoke: (intent) => onSubmit(),
                  ),
                },
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
                        keyboardType: TextInputType.emailAddress,
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
                        decoration: InputDecoration(
                          hintText: AuthConstants.passwordHint,
                          labelText: AuthConstants.passwordLabel,
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            child: Icon(
                              showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.primaryDark,
                              size: 20,
                            ),
                          ),
                        ),
                        obscureText: !showPassword,
                        obscuringCharacter: '#',
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

                      BlocBuilder<AuthCubit, AuthCubitState>(
                        builder: (context, state) {
                          final isLoading =
                              currentIndex == AuthConstants.loginIndex
                              ? state.loginStatus == Status.loading
                              : state.registerStatus == Status.loading;

                          return SizedBox(
                            width: double.infinity,
                            child: GradientButton(
                              label: currentIndex == AuthConstants.loginIndex
                                  ? AuthConstants.loginText
                                  : AuthConstants.createAccountText,
                              onSubmit: onSubmit,
                              isLoading: isLoading,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
