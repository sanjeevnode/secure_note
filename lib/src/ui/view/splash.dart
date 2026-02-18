import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_note/src/src.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  Future<void> _initialize() async {
    final authCubit = context.read<AuthCubit>();
    final isAuthenticated = authCubit.isAuthenticated();
    if (!mounted) return;

    if (isAuthenticated) {
      final user = authCubit.getCurrentUser();
      authCubit.setUser(user: user);

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRouteNames.home,
        (_) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRouteNames.auth,
        (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingWrapper(
      isLoading: true,
      child: AppPageLayout(child: Center(child: AppIcon())),
    );
  }
}
