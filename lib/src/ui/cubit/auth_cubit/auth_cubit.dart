import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_note/src/src.dart';

part 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit({
    required AuthRepository authRepository,
    required UserService userService,
  }) : _authRepository = authRepository,
       _userService = userService,
       super(const AuthCubitState());

  final AuthRepository _authRepository;
  final UserService _userService;

  // Initialize auth state
  Future<void> initialize() async {}

  /// Login with email and password
  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(loginStatus: Status.loading));
    final (error, user) = await _authRepository.login(
      email: email,
      password: password,
    );

    if (error != null || user == null) {
      Logger.e("AuthCubit[login] : $error");
      emit(state.copyWith(loginStatus: Status.error));
      return;
    }

    await createOrValidateUserPinEnabled(user);

    Logger.s("AuthCubit[login] : Login successful. User: ${user.email}");
    emit(state.copyWith(loginStatus: Status.success, user: user));
  }

  Future<void> createOrValidateUserPinEnabled(User user) async {
    final (error, isPinEnabled) = await _userService
        .createOrValidateUserPinEnabled(user);
    if (error != null || isPinEnabled == null) {
      Logger.e("AuthCubit[createOrValidateUserPinEnabled] : $error");
      return;
    }

    if (isPinEnabled) {
      Logger.i(
        "AuthCubit[createOrValidateUserPinEnabled] : User has PIN enabled",
      );
    } else {
      Logger.i(
        "AuthCubit[createOrValidateUserPinEnabled] : User does not have PIN enabled",
      );
    }
  }

  Future<UserEntity?> getUserEntity() async {
    if (state.user == null) {
      Logger.w("AuthCubit[getUserEntity] : No user currently logged in");
      return null;
    }
    final (error, en) = await _userService.getUser(state.user!.uid);
    if (error != null || en == null) {
      Logger.e("AuthCubit[getUserEntity] : $error");
      return null;
    }
    return en;
  }

  Future<bool> isPinEnabled() async {
    if (state.user == null) {
      Logger.w("AuthCubit[isPinEnabled] : No user currently logged in");
      return false;
    }
    final (error, isEnabled) = await _userService.isPinEnabled(state.user!.uid);
    if (error != null) {
      Logger.e("AuthCubit[isPinEnabled] : $error");
      return false;
    }
    return isEnabled;
  }

  /// Register with email, password and username
  Future<void> register({
    required String email,
    required String password,
    required String username,
  }) async {
    emit(state.copyWith(registerStatus: Status.loading));
    final (error, user) = await _authRepository.register(
      email: email,
      password: password,
      username: username,
    );

    if (error != null) {
      Logger.e("AuthCubit[register] : $error");
      emit(state.copyWith(registerStatus: Status.error));
      return;
    }
    Logger.s(
      "AuthCubit[register] : Registration successful. User: ${user?.email}",
    );
    emit(state.copyWith(registerStatus: Status.success));
  }

  /// Logout current user
  Future<void> logout() async {
    final (error, success) = await _authRepository.logout();

    if (error != null) {
      Logger.e("AuthCubit[logout] : $error");
      return;
    }

    Logger.s("AuthCubit[logout] : Logout successful");
    emit(state.copyWith(resetUser: true));
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

  /// Set User
  void setUser({User? user, bool resetUser = false}) {
    emit(state.copyWith(user: user, resetUser: resetUser));
  }

  // Update user PIN
  Future<bool> updatePin(String? newPin) async {
    if (state.user == null) {
      Logger.w("AuthCubit[updatePin] : No user currently logged in");
      return false;
    }
    final (error, success) = await _userService.updatePin(
      state.user!.uid,
      newPin,
    );
    if (error != null || success == false) {
      Logger.e("AuthCubit[updatePin] : $error");
      return false;
    }
    Logger.s("AuthCubit[updatePin] : PIN updated successfully");
    return true;
  }
}
