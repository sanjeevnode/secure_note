part of 'auth_cubit.dart';

class AuthCubitState extends Equatable {
  final Status loginStatus;
  final Status registerStatus;
  final Status pinStatus;
  final Status logoutStatus;
  final User? user;

  const AuthCubitState({
    this.loginStatus = Status.none,
    this.registerStatus = Status.none,
    this.pinStatus = Status.none,
    this.logoutStatus = Status.none,
    this.user,
  });

  AuthCubitState copyWith({
    Status? loginStatus,
    Status? registerStatus,
    User? user,
    bool resetUser = false,
    Status? pinStatus,
    Status? logoutStatus,
  }) {
    return AuthCubitState(
      loginStatus: loginStatus ?? this.loginStatus,
      registerStatus: registerStatus ?? this.registerStatus,
      user: resetUser ? null : user ?? this.user,
      pinStatus: pinStatus ?? this.pinStatus,
      logoutStatus: logoutStatus ?? this.logoutStatus,
    );
  }

  @override
  List<Object?> get props => [
    loginStatus,
    registerStatus,
    user,
    pinStatus,
    logoutStatus,
  ];
}
