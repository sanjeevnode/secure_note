import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_note/src/src.dart';

/// Firebase Authentication Service
/// Handles all Firebase Auth operations
class FirebaseAuthService {
  final FirebaseService _firebaseService;

  FirebaseAuthService(this._firebaseService);

  FirebaseAuth get _auth => _firebaseService.auth;

  /// Login with email and password
  Future<User> login({required String email, required String password}) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw AuthenticationException();
      }

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      throw e.toAppException();
    } catch (e) {
      throw UnexpectedException(message: e.toString(), code: '500');
    }
  }

  /// Register with email, password and username
  Future<User> register({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw RegistrationException();
      }

      // Update display name
      await userCredential.user!.updateDisplayName(username);
      await userCredential.user!.reload();

      return _auth.currentUser!;
    } on FirebaseAuthException catch (e) {
      throw e.toAppException();
    } catch (e) {
      throw UnexpectedException(message: e.toString(), code: '500');
    }
  }

  /// Logout current user
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw UnexpectedException(
        message: 'Logout failed: ${e.toString()}',
        code: '500',
      );
    }
  }

  /// Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  /// Check if user is authenticated
  bool isAuthenticated() {
    return _auth.currentUser != null;
  }

  /// Stream of auth state changes
  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }
}
