import 'package:firebase_auth/firebase_auth.dart';

/// Core Firebase Service - Provides access to Firebase instances
/// This is registered as a singleton in DI
class FirebaseService {
  FirebaseService._();

  static final FirebaseService _instance = FirebaseService._();
  factory FirebaseService() => _instance;

  /// Firebase Auth instance
  FirebaseAuth get auth => FirebaseAuth.instance;

  /// Future: Add Firestore instance
  /// FirebaseFirestore get db => FirebaseFirestore.instance;

  /// Future: Add Storage instance
  /// FirebaseStorage get storage => FirebaseStorage.instance;
}
