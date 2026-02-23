import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secure_note/src/src.dart';

/// Firestore Service
/// Generic wrapper around all Firestore operations.
/// All methods return (AppException?, T?) tuples consistent with the app pattern.
class FirestoreService {
  final FirebaseService _firebaseService;

  FirestoreService(this._firebaseService);

  FirebaseFirestore get _db => _firebaseService.db;

  // ─────────────────────────────────────────────
  // Helpers
  // ─────────────────────────────────────────────

  DocumentReference<Map<String, dynamic>> _doc(String path) => _db.doc(path);

  CollectionReference<Map<String, dynamic>> _col(String path) =>
      _db.collection(path);

  // ─────────────────────────────────────────────
  // CREATE
  // ─────────────────────────────────────────────

  /// Set (create or fully overwrite) a document at [path].
  /// [merge] true → merges with existing data instead of overwriting.
  Future<(AppException?, bool?)> setDocument({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    try {
      await _doc(path).set(data, SetOptions(merge: merge));
      return (null, true);
    } on FirebaseException catch (e) {
      return (
        UnexpectedException(message: e.message ?? e.code, code: e.code),
        null,
      );
    } catch (e) {
      return (UnexpectedException(message: e.toString(), code: '500'), null);
    }
  }

  /// Add a new document to [collectionPath] with an auto-generated ID.
  /// Returns the new document ID on success.
  Future<(AppException?, String?)> addDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) async {
    try {
      final ref = await _col(collectionPath).add(data);
      return (null, ref.id);
    } on FirebaseException catch (e) {
      return (
        UnexpectedException(message: e.message ?? e.code, code: e.code),
        null,
      );
    } catch (e) {
      return (UnexpectedException(message: e.toString(), code: '500'), null);
    }
  }

  // ─────────────────────────────────────────────
  // READ
  // ─────────────────────────────────────────────

  /// Fetch a single document at [path].
  /// Returns the raw data map, or null if the document doesn't exist.
  Future<(AppException?, Map<String, dynamic>?)> getDocument({
    required String path,
  }) async {
    try {
      final snap = await _doc(path).get();
      if (!snap.exists) return (null, null);
      return (null, snap.data());
    } on FirebaseException catch (e) {
      return (
        UnexpectedException(message: e.message ?? e.code, code: e.code),
        null,
      );
    } catch (e) {
      return (UnexpectedException(message: e.toString(), code: '500'), null);
    }
  }

  /// Fetch all documents in a collection at [collectionPath].
  /// Returns a list of maps, each containing the document data + auto-injected `id` field.
  Future<(AppException?, List<Map<String, dynamic>>?)> getCollection({
    required String collectionPath,
  }) async {
    try {
      final snap = await _col(collectionPath).get();
      final docs = snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();
      return (null, docs);
    } on FirebaseException catch (e) {
      return (
        UnexpectedException(message: e.message ?? e.code, code: e.code),
        null,
      );
    } catch (e) {
      return (UnexpectedException(message: e.toString(), code: '500'), null);
    }
  }

  /// Check whether a document at [path] exists.
  Future<(AppException?, bool?)> documentExists({required String path}) async {
    try {
      final snap = await _doc(path).get();
      return (null, snap.exists);
    } on FirebaseException catch (e) {
      return (
        UnexpectedException(message: e.message ?? e.code, code: e.code),
        null,
      );
    } catch (e) {
      return (UnexpectedException(message: e.toString(), code: '500'), null);
    }
  }

  // ─────────────────────────────────────────────
  // UPDATE
  // ─────────────────────────────────────────────

  /// Partially update fields in an existing document at [path].
  /// Only the provided [data] keys are changed; other fields are untouched.
  Future<(AppException?, bool?)> updateDocument({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _doc(path).update(data);
      return (null, true);
    } on FirebaseException catch (e) {
      return (
        UnexpectedException(message: e.message ?? e.code, code: e.code),
        null,
      );
    } catch (e) {
      return (UnexpectedException(message: e.toString(), code: '500'), null);
    }
  }

  // ─────────────────────────────────────────────
  // DELETE
  // ─────────────────────────────────────────────

  /// Delete a document at [path].
  Future<(AppException?, bool?)> deleteDocument({required String path}) async {
    try {
      await _doc(path).delete();
      return (null, true);
    } on FirebaseException catch (e) {
      return (
        UnexpectedException(message: e.message ?? e.code, code: e.code),
        null,
      );
    } catch (e) {
      return (UnexpectedException(message: e.toString(), code: '500'), null);
    }
  }

  /// Delete a specific field from a document at [path].
  Future<(AppException?, bool?)> deleteField({
    required String path,
    required String fieldName,
  }) async {
    try {
      await _doc(path).update({fieldName: FieldValue.delete()});
      return (null, true);
    } on FirebaseException catch (e) {
      return (
        UnexpectedException(message: e.message ?? e.code, code: e.code),
        null,
      );
    } catch (e) {
      return (UnexpectedException(message: e.toString(), code: '500'), null);
    }
  }

  // ─────────────────────────────────────────────
  // QUERY
  // ─────────────────────────────────────────────

  /// Run a query on a collection.
  ///
  /// Example:
  /// ```dart
  /// queryCollection(
  ///   collectionPath: 'notes',
  ///   queryBuilder: (q) => q.where('uid', isEqualTo: uid).orderBy('createdAt', descending: true).limit(20),
  /// );
  /// ```
  Future<(AppException?, List<Map<String, dynamic>>?)> queryCollection({
    required String collectionPath,
    Query<Map<String, dynamic>> Function(
      CollectionReference<Map<String, dynamic>> query,
    )?
    queryBuilder,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _col(collectionPath);
      if (queryBuilder != null) {
        query = queryBuilder(_col(collectionPath));
      }
      final snap = await query.get();
      final docs = snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();
      return (null, docs);
    } on FirebaseException catch (e) {
      return (
        UnexpectedException(message: e.message ?? e.code, code: e.code),
        null,
      );
    } catch (e) {
      return (UnexpectedException(message: e.toString(), code: '500'), null);
    }
  }

  // ─────────────────────────────────────────────
  // STREAMS (Real-time)
  // ─────────────────────────────────────────────

  /// Stream a single document at [path] in real-time.
  /// Emits null if the document doesn't exist.
  Stream<Map<String, dynamic>?> streamDocument({required String path}) {
    return _doc(path).snapshots().map((snap) {
      if (!snap.exists) return null;
      return snap.data();
    });
  }

  /// Stream all documents in [collectionPath] in real-time.
  Stream<List<Map<String, dynamic>>> streamCollection({
    required String collectionPath,
    Query<Map<String, dynamic>> Function(
      CollectionReference<Map<String, dynamic>> query,
    )?
    queryBuilder,
  }) {
    Query<Map<String, dynamic>> query = _col(collectionPath);
    if (queryBuilder != null) {
      query = queryBuilder(_col(collectionPath));
    }
    return query.snapshots().map(
      (snap) => snap.docs.map((d) => {'id': d.id, ...d.data()}).toList(),
    );
  }

  // ─────────────────────────────────────────────
  // BATCH WRITES
  // ─────────────────────────────────────────────

  /// Execute multiple write operations atomically.
  ///
  /// Example:
  /// ```dart
  /// batchWrite((batch, db) {
  ///   batch.set(db.doc('users/uid'), {...});
  ///   batch.update(db.doc('meta/stats'), {'count': FieldValue.increment(1)});
  ///   batch.delete(db.doc('temp/oldDoc'));
  /// });
  /// ```
  Future<(AppException?, bool?)> batchWrite(
    void Function(WriteBatch batch, FirebaseFirestore db) operations,
  ) async {
    try {
      final batch = _db.batch();
      operations(batch, _db);
      await batch.commit();
      return (null, true);
    } on FirebaseException catch (e) {
      return (
        UnexpectedException(message: e.message ?? e.code, code: e.code),
        null,
      );
    } catch (e) {
      return (UnexpectedException(message: e.toString(), code: '500'), null);
    }
  }

  // ─────────────────────────────────────────────
  // TRANSACTIONS
  // ─────────────────────────────────────────────

  /// Run multiple reads and writes as an atomic transaction.
  /// If any read/write fails, the entire transaction is rolled back.
  ///
  /// Example:
  /// ```dart
  /// runTransaction((txn) async {
  ///   final snap = await txn.get(db.doc('users/uid'));
  ///   final current = snap.data()?['count'] ?? 0;
  ///   txn.update(db.doc('users/uid'), {'count': current + 1});
  /// });
  /// ```
  Future<(AppException?, T?)> runTransaction<T>(
    Future<T> Function(Transaction txn) handler,
  ) async {
    try {
      final result = await _db.runTransaction(handler);
      return (null, result);
    } on FirebaseException catch (e) {
      return (
        UnexpectedException(message: e.message ?? e.code, code: e.code),
        null,
      );
    } catch (e) {
      return (UnexpectedException(message: e.toString(), code: '500'), null);
    }
  }

  // ─────────────────────────────────────────────
  // FIELD VALUE HELPERS
  // ─────────────────────────────────────────────

  /// Firestore server timestamp — use in data maps to let Firestore
  /// set the timestamp on the server side.
  /// ```dart
  /// {'createdAt': firestoreService.serverTimestamp}
  /// ```
  FieldValue get serverTimestamp => FieldValue.serverTimestamp();

  /// Increment a numeric field by [amount] atomically.
  /// ```dart
  /// {'views': firestoreService.increment(1)}
  /// ```
  FieldValue increment(num amount) => FieldValue.increment(amount);

  /// Append items to an array field atomically (no duplicates added).
  FieldValue arrayUnion(List<dynamic> items) => FieldValue.arrayUnion(items);

  /// Remove items from an array field atomically.
  FieldValue arrayRemove(List<dynamic> items) => FieldValue.arrayRemove(items);

  /// Expose the raw Firestore instance for advanced usage.
  FirebaseFirestore get instance => _db;
}
