import 'package:firebase_auth/firebase_auth.dart';

class UserEntity {
  final String uid;
  final String email;
  final String? displayName;
  final String? pin;

  UserEntity({
    required this.uid,
    required this.email,
    this.displayName,
    this.pin,
  });

  factory UserEntity.fromJson(Map<String, dynamic> map) {
    return UserEntity(
      uid: map['uid']!,
      email: map['email']!,
      displayName: map['displayName'],
      pin: map['pin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      if (displayName != null) 'displayName': displayName,
      if (pin != null) 'pin': pin,
    };
  }

  UserEntity copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? pin,
    bool clearPin = false,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      pin: clearPin ? null : pin ?? this.pin,
    );
  }

  @override
  String toString() => toJson().toString();

  static UserEntity fromUser(User user) {
    return UserEntity(
      uid: user.uid,
      email: user.email!,
      displayName: user.displayName,
    );
  }
}
