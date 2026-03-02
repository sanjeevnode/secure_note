import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserEntity {
  final String uid;
  final String email;
  final String pin;
  final DateTime pinUpdatedAt;

  UserEntity({
    required this.uid,
    required this.email,
    this.pin = "",
    DateTime? pinUpdatedAt,
  }) : pinUpdatedAt = pinUpdatedAt ?? DateTime.now();

  factory UserEntity.fromJson(Map<String, dynamic> map) {
    return UserEntity(
      uid: map['uid'],
      email: map['email'],
      pin: map['pin'] ?? "",
      pinUpdatedAt: map['pinUpdatedAt'] != null
          ? (map['pinUpdatedAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'pin': pin,
      'pinUpdatedAt': Timestamp.fromDate(pinUpdatedAt),
    };
  }

  static UserEntity fromUser(User user) {
    return UserEntity(uid: user.uid, email: user.email!);
  }

  @override
  String toString() => toJson().toString();
}
