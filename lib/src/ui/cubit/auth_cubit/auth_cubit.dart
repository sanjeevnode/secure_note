import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:secure_note/src/src.dart';

part 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthCubitState());

  final AuthRepository _authRepository;

  Future<void> login({required String email, required String password}) async {
    final (error, userData) = await _authRepository.login(
      email: email,
      password: password,
    );

    if (error != null) {
      Logger.e("AuthCubit[login] : $error");
      return;
    }

    Logger.s("AuthCubit[login] : Login successful. User data: $userData");
    // Handle successful login (e.g., navigate to home screen)
  }

  Future<void> register({
    required String email,
    required String password,
    required String username,
  }) async {
    final (error, userData) = await _authRepository.register(
      email: email,
      password: password,
      username: username,
    );

    if (error != null) {
      Logger.e("AuthCubit[register] : $error");
      return;
    }

    Logger.s(
      "AuthCubit[register] : Registration successful. User data: $userData",
    );
    // Handle successful registration (e.g., navigate to home screen)
  }
}
