import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_note/src/src.dart';

abstract class AppException implements Exception {
  AppException({this.code = '', this.message = '', this.data});

  final String code;
  final String message;
  final dynamic data;

  @override
  String toString() => message;
}

extension AppErrorExtension on Object {
  AppException toAppException() {
    if (this is AppException) {
      return this as AppException;
    }
    return UnexpectedException(message: toString());
  }
}

extension ResponseExceptionParser on Response {
  AppException toAppException() {
    try {
      final data = this.data;

      if (data is Map<String, dynamic>) {
        final message = data['message']?.toString();
        final errors = data['errors'];

        if (message != null && message.isNotEmpty) {
          return UnProcessableContentException(
            code: statusCode?.toString() ?? '',
            message: message,
            data: errors ?? data,
          );
        }
      }

      // If message not found → fallback
      return UnexpectedException(
        code: statusCode?.toString() ?? '',
        message: AppConstants.somethingWentWrong,
        data: data,
      );
    } catch (_) {
      return UnexpectedException(
        code: statusCode?.toString() ?? '',
        message: AppConstants.somethingWentWrong,
        data: data,
      );
    }
  }
}

class TokenNotFoundException extends AppException {
  TokenNotFoundException({
    super.code,
    super.message = AppConstants.tokenNotFound,
    super.data,
  });
}

class UnexpectedException extends AppException {
  UnexpectedException({
    super.code,
    super.message = AppConstants.somethingWentWrong,
    super.data,
  });
}

class MissingDataException extends AppException {
  MissingDataException({super.code, super.message, super.data});
}

class FileSizeExceededException extends AppException {
  FileSizeExceededException({
    super.code,
    super.message = AppConstants.fileSizeExceeded,
    super.data,
  });
}

class UnProcessableContentException extends AppException {
  UnProcessableContentException({
    super.code,
    super.message = AppConstants.unProcessableContent,
    super.data,
  });
}

class MethodChannelException extends AppException {
  MethodChannelException({
    super.code,
    super.message = AppConstants.methodChannelError,
    super.data,
  });
}

// ===== Firebase Auth Exceptions =====

class UserNotFoundException extends AppException {
  UserNotFoundException({
    super.code = '404',
    super.message = 'No user found with this email.',
    super.data,
  });
}

class WrongPasswordException extends AppException {
  WrongPasswordException({
    super.code = '401',
    super.message = 'Incorrect password.',
    super.data,
  });
}

class EmailAlreadyInUseException extends AppException {
  EmailAlreadyInUseException({
    super.code = '409',
    super.message = 'This email is already registered.',
    super.data,
  });
}

class InvalidEmailException extends AppException {
  InvalidEmailException({
    super.code = '400',
    super.message = 'Invalid email address.',
    super.data,
  });
}

class WeakPasswordException extends AppException {
  WeakPasswordException({
    super.code = '400',
    super.message = 'Password is too weak.',
    super.data,
  });
}

class UserDisabledException extends AppException {
  UserDisabledException({
    super.code = '403',
    super.message = 'This account has been disabled.',
    super.data,
  });
}

class TooManyRequestsException extends AppException {
  TooManyRequestsException({
    super.code = '429',
    super.message = 'Too many attempts. Please try again later.',
    super.data,
  });
}

class OperationNotAllowedException extends AppException {
  OperationNotAllowedException({
    super.code = '403',
    super.message = 'This operation is not allowed.',
    super.data,
  });
}

class InvalidCredentialException extends AppException {
  InvalidCredentialException({
    super.code = '401',
    super.message =
        'Invalid credentials. Please check your email and password.',
    super.data,
  });
}

class AuthenticationException extends AppException {
  AuthenticationException({
    super.code = '401',
    super.message = 'Login failed. Please try again.',
    super.data,
  });
}

class RegistrationException extends AppException {
  RegistrationException({
    super.code = '400',
    super.message = 'Registration failed. Please try again.',
    super.data,
  });
}

/// Extension to convert FirebaseAuthException to AppException
extension FirebaseAuthExceptionParser on FirebaseAuthException {
  AppException toAppException() {
    switch (code) {
      case 'user-not-found':
        return UserNotFoundException();
      case 'wrong-password':
        return WrongPasswordException();
      case 'email-already-in-use':
        return EmailAlreadyInUseException();
      case 'invalid-email':
        return InvalidEmailException();
      case 'weak-password':
        return WeakPasswordException();
      case 'user-disabled':
        return UserDisabledException();
      case 'too-many-requests':
        return TooManyRequestsException();
      case 'operation-not-allowed':
        return OperationNotAllowedException();
      case 'invalid-credential':
        return InvalidCredentialException();
      default:
        return UnexpectedException(
          message: message ?? 'An authentication error occurred.',
          code: '500',
        );
    }
  }
}
