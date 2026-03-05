import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_note/src/src.dart';

class PinSetupScreen extends StatefulWidget {
  const PinSetupScreen({super.key});

  @override
  State<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> {
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

    if (!isAuthenticated) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRouteNames.auth,
        (_) => false,
      );
    } else {
      final isPinEnabled = await authCubit.isPinEnabled();
      if (!mounted) return;
      if (isPinEnabled) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRouteNames.home,
          (_) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppPageLayout(
      appBar: const CustomAppBar(title: 'Set up PIN'),
      child: Column(
        children: [
          const Text('PIN setup screen'),
          const SizedBox(height: 16),
          const Text('This is a placeholder for the PIN setup screen.'),
          const SizedBox(height: 16),
          GradientButton(
            label: 'Logout',
            onSubmit: () async {
              await context.read<AuthCubit>().logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRouteNames.auth,
                (_) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
