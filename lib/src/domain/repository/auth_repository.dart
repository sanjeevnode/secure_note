import 'package:secure_note/src/core/utils/exception.dart';

abstract class AuthRepository {
  /*
   * Login with email and password
   */
  Future<(AppException?, Map<String, dynamic>?)> login({
    required String email,
    required String password,
  });

  /*
   * Register with email, password and username
   */
  Future<(AppException?, Map<String, dynamic>?)> register({
    required String email,
    required String password,
    required String username,
  });
}
