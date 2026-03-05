part of 'auth_cubit.dart';

class AuthCubitState extends Equatable {
  final Status loginStatus;
  final Status registerStatus;
  final Status pinStatus;
  final User? user;

  const AuthCubitState({
    this.loginStatus = Status.none,
    this.registerStatus = Status.none,
    this.pinStatus = Status.none,
    this.user,
  });

  AuthCubitState copyWith({
    Status? loginStatus,
    Status? registerStatus,
    User? user,
    bool resetUser = false,
    Status? pinStatus,
  }) {
    return AuthCubitState(
      loginStatus: loginStatus ?? this.loginStatus,
      registerStatus: registerStatus ?? this.registerStatus,
      user: resetUser ? null : user ?? this.user,
      pinStatus: pinStatus ?? this.pinStatus,
    );
  }

  @override
  List<Object?> get props => [loginStatus, registerStatus, user, pinStatus];
}
