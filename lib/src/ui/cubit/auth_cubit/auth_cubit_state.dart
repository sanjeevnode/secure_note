part of 'auth_cubit.dart';

class AuthCubitState extends Equatable {
  final Status loginStatus;
  final Status registerStatus;

  const AuthCubitState({
    this.loginStatus = Status.none,
    this.registerStatus = Status.none,
  });

  AuthCubitState copyWith({Status? loginStatus, Status? registerStatus}) {
    return AuthCubitState(
      loginStatus: loginStatus ?? this.loginStatus,
      registerStatus: registerStatus ?? this.registerStatus,
    );
  }

  @override
  List<Object?> get props => [loginStatus, registerStatus];
}
