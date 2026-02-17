import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_note/src/core/core.dart';
import 'package:secure_note/src/data/data.dart';
import 'package:secure_note/src/domain/domain.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthService _authService;

  AuthRepositoryImpl(this._authService);

  /// Login with email and password
  @override
  Future<(AppException?, User?)> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _authService.login(email: email, password: password);
      return (null, user);
    } catch (e) {
      return (e.toAppException(), null);
    }
  }

  /// Register with email, password and username
  @override
  Future<(AppException?, User?)> register({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final user = await _authService.register(
        email: email,
        password: password,
        username: username,
      );
      return (null, user);
    } catch (e) {
      return (e.toAppException(), null);
    }
  }

  /// Logout current user
  @override
  Future<(AppException?, bool?)> logout() async {
    try {
      await _authService.logout();
      return (null, true);
    } catch (e) {
      return (e.toAppException(), null);
    }
  }

  /// Get current user
  @override
  (AppException?, User?) getCurrentUser() {
    try {
      final user = _authService.getCurrentUser();
      return (null, user);
    } catch (e) {
      return (e.toAppException(), null);
    }
  }

  /// Check if user is authenticated
  @override
  (AppException?, bool?) isAuthenticated() {
    try {
      final isAuth = _authService.isAuthenticated();
      return (null, isAuth);
    } catch (e) {
      return (e.toAppException(), null);
    }
  }

  /// Stream of auth state changes
  @override
  Stream<User?> authStateChanges() {
    return _authService.authStateChanges();
  }
}
