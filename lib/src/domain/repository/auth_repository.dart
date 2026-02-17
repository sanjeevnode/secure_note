import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_note/src/core/core.dart';

abstract class AuthRepository {
  /*
   * Login with email and password
   */
  Future<(AppException?, User?)> login({
    required String email,
    required String password,
  });

  /*
   * Register with email, password and username
   */
  Future<(AppException?, User?)> register({
    required String email,
    required String password,
    required String username,
  });

  /*
   * Logout current user
   */
  Future<(AppException?, bool?)> logout();

  /*
   * Get current user
   */
  (AppException?, User?) getCurrentUser();

  /*
   * Check if user is authenticated
   */
  (AppException?, bool?) isAuthenticated();

  /*
   * Stream of auth state changes
   */
  Stream<User?> authStateChanges();
}
