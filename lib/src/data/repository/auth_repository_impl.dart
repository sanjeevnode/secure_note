import 'package:secure_note/src/core/utils/exception.dart';
import 'package:secure_note/src/domain/domain.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<(AppException?, Map<String, dynamic>?)> login({
    required String email,
    required String password,
  }) async {
    try {
      return (null, {"token": "dummy_token"});
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
      return (null, {"token": "dummy_token"});
    } catch (e) {
      return (e.toAppException(), null);
    }
  }
}
