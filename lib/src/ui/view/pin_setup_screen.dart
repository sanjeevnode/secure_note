import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:secure_note/src/src.dart';

class PinSetupScreen extends StatefulWidget {
  const PinSetupScreen({super.key});

  @override
  State<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> {
  String _pin = "";
  String _confirmPin = "";

  Future<void> _logout() async {
    await context.read<AuthCubit>().logout();
    if (!mounted) return;
    context.go(AppRouteNames.auth);
  }

  Future<void> handleSubmit() async {
    final authCubit = context.read<AuthCubit>();
    if (_pin != _confirmPin) {
      Toast.error('PIN and Confirm PIN do not match.');
      return;
    }
    if (_pin.length != 6) {
      Toast.error('PIN must be exactly 6 characters long.');
      return;
    }
    final validPinPattern = RegExp(r'^[A-Za-z0-9@#_-]{6}$');
    if (!validPinPattern.hasMatch(_pin)) {
      Toast.error(
        'PIN can only contain letters, numbers, and @, #, _ or - characters.',
      );
      return;
    }
    await authCubit.updatePin(_pin);
  }

  void _handleListner(Status pinStatus) {
    if (pinStatus == Status.success) {
      context.go(AppRouteNames.home);
    } else if (pinStatus == Status.error) {
      Toast.error('Failed to update PIN. Please try again.');
    }
  }

  PinTheme get defaultPinTheme => PinTheme(
    width: 56,
    height: 56,
    textStyle: AppTextStyle.textLgSemibold.copyWith(
      color: AppColors.primaryDark,
    ),
    decoration: BoxDecoration(
      color: AppColors.white,
      border: Border.all(color: AppColors.primaryDark),
      borderRadius: BorderRadius.circular(14),
    ),
  );

  PinTheme get focusedPinTheme => defaultPinTheme.copyDecorationWith(
    border: Border.all(color: AppColors.emeraldPrimary, width: 2),
    borderRadius: BorderRadius.circular(14),
  );

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

                Text(
                  'Note: PIN must be 6 characters and may include A-Z, a-z, 0-9, @, #, _ or -.',
                  style: AppTextStyle.textMdSemibold.copyWith(
                    color: Colors.deepOrange,
                  ),
                ),
                const SizedBox(height: 20),
                Text('PIN', style: AppTextStyle.textLgSemibold),
                const SizedBox(height: 10),
                Pinput(
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  showCursor: true,
                  length: 6,
                  obscureText: true,
                  obscuringCharacter: '#',
                  onCompleted: (pin) => setState(() {
                    _pin = pin;
                  }),
                ),
                const SizedBox(height: 20),
                Text('Confirm PIN', style: AppTextStyle.textLgSemibold),
                const SizedBox(height: 10),
                Pinput(
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  showCursor: true,
                  length: 6,
                  obscureText: true,
                  obscuringCharacter: '#',
                  onCompleted: (pin) => setState(() {
                    _confirmPin = pin;
                  }),
                ),
                const SizedBox(height: 20),
                GradientButton(label: "Submit", onSubmit: handleSubmit),
              ],
            ),
          ),
        );
      },
    );
  }
}
