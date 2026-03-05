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

  Future<void> _logout() async {
    await context.read<AuthCubit>().logout();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouteNames.auth,
      (_) => false,
    );
  }

  Future<void> _navigateToHome() async {
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouteNames.home,
      (_) => false,
    );
  }

  Future<void> updatePin() async {
    final authCubit = context.read<AuthCubit>();
    await authCubit.updatePin('1234');
  }

  void _handleListner(Status pinStatus) {
    if (pinStatus == Status.success) {
      _navigateToHome();
    } else if (pinStatus == Status.error) {
      Toast.error('Failed to update PIN. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthCubitState>(
      listener: (context, state) {
        _handleListner(state.pinStatus);
      },
      builder: (context, state) {
        return LoadingWrapper(
          isLoading: state.pinStatus == Status.loading,
          child: AppPageLayout(
            appBar: const CustomAppBar(title: 'Set up PIN'),
            child: Column(
              children: [
                const Text('PIN setup screen'),
                const SizedBox(height: 16),
                const Text('This is a placeholder for the PIN setup screen.'),
                const SizedBox(height: 46),
                GradientButton(
                  label: 'Update PIN',
                  onSubmit: () => updatePin(),
                ),
                const SizedBox(height: 56),
                GradientButton(label: 'Logout', onSubmit: () => _logout()),
              ],
            ),
          ),
        );
      },
    );
  }
}
