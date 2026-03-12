class PinSetupConstants {
  PinSetupConstants._();

  static const String title = 'Manage PIN';

  static const String updatePinTitle = 'Change Security PIN';

  static const String updatePinDescription =
      'Update your PIN to continue protecting your encrypted notes.';
  static const String setupPinTitle = 'Create Security PIN';

  static const String setupPinDescription =
      'This code keeps your private notes encrypted and safe.';

  static const String pinLabel = 'PIN';
  static const String confirmPinLabel = 'Confirm PIN';
  static const String submitLabel = 'Submit';

  static const String pinNote =
      'Note: PIN must be 6 characters and may include A-Z, a-z, 0-9, @, #, _ or -.';

  static const String errorPinMismatch = 'PIN and Confirm PIN do not match.';
  static const String errorPinLength = 'PIN must be exactly 6 characters long.';
  static const String errorPinInvalidChars =
      'PIN can only contain letters, numbers, and @, #, _ or - characters.';
  static const String errorPinUpdateFailed =
      'Failed to update PIN. Please try again.';
}
