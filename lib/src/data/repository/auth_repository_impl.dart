import 'package:secure_note/src/core/utils/exception.dart';
import 'package:secure_note/src/data/service/firebase_auth_service.dart';
import 'package:secure_note/src/domain/domain.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Future<(AppException?, Map<String, dynamic>?)> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _authService.login(email: email, password: password);

      return (
        null,
        {
          "token": await user.getIdToken(),
          "uid": user.uid,
          "email": user.email,
          "displayName": user.displayName,
        },
      );
    } on AppException catch (e) {
      return (e, null);
    } catch (e) {
      return (e.toAppException(), null);
    }
  }

  @override
  Future<(AppException?, Map<String, dynamic>?)> register({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final user = await _authService.register(
        email: email,
        password: password,
        username: username,
      );

      return (
        null,
        {
          "token": await user.getIdToken(),
          "uid": user.uid,
          "email": user.email,
          "displayName": user.displayName,
        },
      );
    } on AppException catch (e) {
      return (e, null);
    } catch (e) {
      return (e.toAppException(), null);
    }
  }
}
