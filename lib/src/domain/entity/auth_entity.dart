class AuthEntity {
  final String email;
  final String password;
  final String? username;

  AuthEntity({required this.email, required this.password, this.username});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      if (username != null) 'username': username,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
