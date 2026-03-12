import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_note/src/src.dart';

class PinSetupScreen extends StatefulWidget {
  const PinSetupScreen({super.key});

  @override
  State<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> {
  Future<void> _logout() async {
    await context.read<AuthCubit>().logout();
    if (!mounted) return;
    context.go(AppRouteNames.auth);
  }

  Future<void> updatePin() async {
    final authCubit = context.read<AuthCubit>();
    await authCubit.updatePin('1234');
  }

  void _handleListner(Status pinStatus) {
    if (pinStatus == Status.success) {
      context.go(AppRouteNames.home);
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
          isLoading:
              state.pinStatus == Status.loading ||
              state.logoutStatus == Status.loading,
          child: AppPageLayout(
            appBar: CustomAppBar(
              leading: [
                Assets.icons.manage.svg(width: 24, height: 24),
                const SizedBox(width: 12),
              ],
              title: PinSetupConstants.title,
              actions: [
                Clickable(
                  onTap: () {
                    _logout();
                  },
                  child: Assets.icons.logout.svg(
                    width: 28,
                    height: 28,
                    // ignore: deprecated_member_use_from_same_package
                    color: AppColors.redPrimary,
                  ),
                ),
              ],
            ),
            fixedContentWidth: true,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 30),

                const SizedBox(height: 30),
                Text(
                  PinSetupConstants.setupPinTitle,
                  style: AppTextStyle.text2xlSemibold,
                ),
                const SizedBox(height: 8),
                Text(
                  PinSetupConstants.setupPinDescription,
                  style: AppTextStyle.textLgRegular.copyWith(
                    color: AppColors.grayDark,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
