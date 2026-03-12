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
      Toast.error(PinSetupConstants.errorPinMismatch);
      return;
    }
    if (_pin.length != 6) {
      Toast.error(PinSetupConstants.errorPinLength);
      return;
    }
    final validPinPattern = RegExp(r'^[A-Za-z0-9@#_-]{6}$');
    if (!validPinPattern.hasMatch(_pin)) {
      Toast.error(PinSetupConstants.errorPinInvalidChars);
      return;
    }
    await authCubit.updatePin(_pin);
  }

  void _handleListner(Status pinStatus) {
    if (pinStatus == Status.success) {
      context.go(AppRouteNames.home);
    } else if (pinStatus == Status.error) {
      Toast.error(PinSetupConstants.errorPinUpdateFailed);
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
                  PinSetupConstants.pinNote,
                  style: AppTextStyle.textMdSemibold.copyWith(
                    color: Colors.deepOrange,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  PinSetupConstants.pinLabel,
                  style: AppTextStyle.textLgSemibold,
                ),
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
                Text(
                  PinSetupConstants.confirmPinLabel,
                  style: AppTextStyle.textLgSemibold,
                ),
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
                GradientButton(
                  label: PinSetupConstants.submitLabel,
                  onSubmit: handleSubmit,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
