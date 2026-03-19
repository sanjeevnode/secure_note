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
      return (null, user.pin.isNotEmpty);
    } catch (e) {
      return (e.toAppException(), false);
    }
  }

  Future<(AppException?, bool)> updatePin(String uid, String? newPin) async {
    try {
      if (newPin == null || newPin.isEmpty) {
        return (null, true); // No update needed if newPin is null or empty
      }

      final payload = {'pin': newPin, 'pinUpdatedAt': DateTime.now()};

      final (error, _) = await _firestoreService.updateDocument(
        path: _path(uid),
        data: payload,
      );
      if (error != null) throw error;
      return (null, true);
    } catch (e) {
      return (e.toAppException(), false);
    }
  }

  Future<(AppException?, bool?)> createOrValidateUserPinEnabled(
    User user,
  ) async {
    try {
      final (error, data) = await _firestoreService.getDocument(
        path: _path(user.uid),
      );
      if (error != null) throw error;
      UserEntity? userEntity;
      if (data != null) {
        userEntity = UserEntity.fromJson(data);
      }
      if (userEntity == null) {
        // If user doesn't exist, create it
        final (createError, _) = await createUser(user);
        if (createError != null) {
          throw createError;
        }
        return (null, false); // New user created, pin not enabled
      }
      final isPinEnabled = userEntity.pin.isNotEmpty;
      return (null, isPinEnabled);
    } catch (e) {
      return (e.toAppException(), null);
    }
  }

  Future<(AppException?, bool)> verifyPin({
    required String uid,
    required String pin,
  }) async {
    try {
      final (error, data) = await _firestoreService.getDocument(
        path: _path(uid),
      );
      if (error != null) throw error;
      if (data == null) {
        throw MissingDataException(message: 'User not found', code: '404');
      }
      final user = UserEntity.fromJson(data);
      return (null, user.pin == pin);
    } catch (e) {
      return (e.toAppException(), false);
    }
  }
}
