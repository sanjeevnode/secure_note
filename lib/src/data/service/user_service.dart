import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_note/src/src.dart';

class UserService {
  final FirestoreService _firestoreService;

  UserService({required FirestoreService firestoreService})
    : _firestoreService = firestoreService;

  String _path(String uid) => '${FirebaseCollectionConstants.users}/$uid';

  Future<(AppException?, UserEntity?)> createUser(User user) async {
    try {
      final userEntity = UserEntity.fromUser(user);
      final (error, _) = await _firestoreService.setDocument(
        path: _path(user.uid),
        data: userEntity.toJson(),
      );
      if (error != null) throw error;
      return (null, userEntity);
    } catch (e) {
      return (e.toAppException(), null);
    }
  }

  Future<(AppException?, UserEntity?)> getUser(String uid) async {
    try {
      final (error, data) = await _firestoreService.getDocument(
        path: _path(uid),
      );
      if (error != null) throw error;
      if (data == null) {
        throw MissingDataException(message: 'User not found', code: '404');
      }
      return (null, UserEntity.fromJson(data));
    } catch (e) {
      return (e.toAppException(), null);
    }
  }

  Future<(AppException?, bool)> isPinEnabled(String uid) async {
    try {
      final (error, data) = await _firestoreService.getDocument(
        path: _path(uid),
      );
      if (error != null) throw error;
      if (data == null) {
        throw MissingDataException(message: 'User not found', code: '404');
      }
      final user = UserEntity.fromJson(data);
      return (null, user.pin != null && user.pin!.isNotEmpty);
    } catch (e) {
      return (e.toAppException(), false);
    }
  }

  Future<(AppException?, bool)> updatePin(String uid, String? newPin) async {
    try {
      final updateData = newPin != null
          ? {'pin': newPin}
          : {'pin': FieldValue.delete()};
      final (error, _) = await _firestoreService.updateDocument(
        path: _path(uid),
        data: updateData,
      );
      if (error != null) throw error;
      return (null, true);
    } catch (e) {
      return (e.toAppException(), false);
    }
  }
}
