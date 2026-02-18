class AuthConstants {
  AuthConstants._();

  static const String loginText = "Login";
  static const String registerText = "Register";
  static const String createAccountText = "Create Account";
  static const int loginIndex = 0;
  static const int registerIndex = 1;

  // Form labels
  static const String usernameLabel = "Username";
  static const String emailLabel = "Email";
  static const String passwordLabel = "Password";

  // Form hints
  static const String usernameHint = "Choose a username";
  static const String emailHint = "your@email.com";
  static const String passwordHint = "##########";

  // Form validation messages
  static const String usernameRequired = "Username is required";
  static const String emailRequired = "Email is required";
  static const String emailInvalid = "Please enter a valid email";
  static const String passwordRequired = "Password is required";
  static const String passwordMinLength =
      "Password must be at least 6 characters";

  // Success messages
  static const String registrationSuccess =
      "Registration successful! Please login.";
  static const String loginSuccess = "Login successful!";

  // Error messages
  static const String registrationError =
      "Registration failed. Please try again.";
  static const String loginError =
      "Login failed. Please check your credentials.";
}
