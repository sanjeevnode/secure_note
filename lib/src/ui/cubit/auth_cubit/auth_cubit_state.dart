part of 'auth_cubit.dart';

class AuthCubitState extends Equatable {
  final Status loginStatus;
  final Status registerStatus;
  final User? user;

  const AuthCubitState({
    this.loginStatus = Status.none,
    this.registerStatus = Status.none,
    this.user,
  });

  AuthCubitState copyWith({
    Status? loginStatus,
    Status? registerStatus,
    User? user,
    bool resetUser = false,
  }) {
    return AuthCubitState(
      loginStatus: loginStatus ?? this.loginStatus,
      registerStatus: registerStatus ?? this.registerStatus,
      user: resetUser ? null : user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [loginStatus, registerStatus, user];
}
