import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_note/src/src.dart';

part 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthCubitState());

  final AuthRepository _authRepository;

  /// Login with email and password
  Future<void> login({required String email, required String password}) async {
    final (error, user) = await _authRepository.login(
      email: email,
      password: password,
    );

    if (error != null) {
      Logger.e("AuthCubit[login] : $error");
      return;
    }

    Logger.s("AuthCubit[login] : Login successful. User: ${user?.email}");
  }

  /// Register with email, password and username
  Future<void> register({
    required String email,
    required String password,
    required String username,
  }) async {
    final (error, user) = await _authRepository.register(
      email: email,
      password: password,
      username: username,
    );

    if (error != null) {
      Logger.e("AuthCubit[register] : $error");
      return;
    }

    Logger.s(
      "AuthCubit[register] : Registration successful. User: ${user?.email}",
    );
  }

  /// Logout current user
  Future<void> logout() async {
    final (error, success) = await _authRepository.logout();

    if (error != null) {
      Logger.e("AuthCubit[logout] : $error");
      return;
    }

    Logger.s("AuthCubit[logout] : Logout successful");
  }

  /// Get current user
  User? getCurrentUser() {
    final (error, user) = _authRepository.getCurrentUser();

    if (error != null) {
      Logger.e("AuthCubit[getCurrentUser] : $error");
      return null;
    }

    if (user == null) {
      Logger.w("AuthCubit[getCurrentUser] : No user currently logged in");
      return null;
    }

    Logger.s("AuthCubit[getCurrentUser] : User: ${user.email}");
    return user;
  }

  /// Check if user is authenticated
  bool isAuthenticated() {
    final (error, isAuth) = _authRepository.isAuthenticated();

    if (error != null) {
      Logger.e("AuthCubit[isAuthenticated] : $error");
      return false;
    }

    Logger.i("AuthCubit[isAuthenticated] : $isAuth");
    return isAuth ?? false;
  }

  /// Listen to auth state changes
  void listenToAuthStateChanges() {
    _authRepository.authStateChanges().listen((user) {
      if (user == null) {
        Logger.i("AuthCubit[authStateChanges] : User signed out");
      } else {
        Logger.i("AuthCubit[authStateChanges] : User signed in: ${user.uid}");
      }
    });
  }
}
