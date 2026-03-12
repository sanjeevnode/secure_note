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
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
  }

  Future<void> _initialize() async {
    final authCubit = context.read<AuthCubit>();
    final isAuthenticated = authCubit.isAuthenticated();
    if (!mounted) return;

    if (!isAuthenticated) {
      context.go(AppRouteNames.auth);
      return;
    }

    if (authCubit.state.user == null) {
      authCubit.setUser(user: authCubit.getCurrentUser());
    }

    final isPinEnabled = await authCubit.isPinEnabled();
    if (!mounted) return;

    if (!isPinEnabled) {
      context.go(AppRouteNames.pinSetup);
    } else {
      context.go(AppRouteNames.home);
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
