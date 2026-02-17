import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_note/src/src.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthCubit>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppPageLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const AppIcon(),
          const SizedBox(height: 12),
          Text(AppConstants.appName, style: AppTextStyle.text2xlSemibold),

          const SizedBox(height: 20),
          const AuthForm(),
          const SizedBox(height: 20),
          Text(
            AppConstants.appDesc,
            style: AppTextStyle.textMdRegular.copyWith(
              color: AppColors.grayDark,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
