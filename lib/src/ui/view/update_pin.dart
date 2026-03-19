import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:secure_note/src/src.dart';

class UpdatePin extends StatefulWidget {
  const UpdatePin({super.key});

  @override
  State<UpdatePin> createState() => _UpdatePinState();
}

class _UpdatePinState extends State<UpdatePin> {
  String _currentPin = "";
  String _pin = "";
  String _confirmPin = "";

  Future<void> handleSubmit() async {
    if (_currentPin.isEmpty && _pin.isEmpty && _confirmPin.isEmpty) {
      Toast.error('Please enter all fields.');
      return;
    }
    final authCubit = context.read<AuthCubit>();
    final isValid = await authCubit.verifyPin(_currentPin);
    if (!isValid) {
      Toast.error('Current PIN is incorrect.');
      return;
    }
    if (_pin != _confirmPin) {
      Toast.error(PinSetupConstants.errorPinMismatch);
      return;
    }
    if (_pin.length != 6) {
      Toast.error(PinSetupConstants.errorPinLength);
      return;
    }
    final validPinPattern = RegExp(PinSetupConstants.pinValidator);
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
              showBackButton: true,
            ),
            fixedContentWidth: true,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 30),

                const SizedBox(height: 30),
                Text(
                  PinSetupConstants.updatePinTitle,
                  style: AppTextStyle.text2xlSemibold,
                ),
                const SizedBox(height: 8),
                Text(
                  PinSetupConstants.updatePinDescription,
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
                  PinSetupConstants.currentPinLabel,
                  style: AppTextStyle.textLgSemibold,
                ),
                const SizedBox(height: 10),
                Pinput(
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  keyboardType: TextInputType.text,
                  showCursor: true,
                  length: 6,
                  obscureText: true,
                  obscuringCharacter: '#',
                  onCompleted: (pin) => setState(() {
                    _currentPin = pin;
                  }),
                ),
                const SizedBox(height: 20),
                Text(
                  PinSetupConstants.newPinLabel,
                  style: AppTextStyle.textLgSemibold,
                ),
                const SizedBox(height: 10),
                Pinput(
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  keyboardType: TextInputType.text,
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
                  PinSetupConstants.confirmNewPinLabel,
                  style: AppTextStyle.textLgSemibold,
                ),
                const SizedBox(height: 10),
                Pinput(
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  keyboardType: TextInputType.text,
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
