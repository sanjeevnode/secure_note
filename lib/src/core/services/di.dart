import 'package:get_it/get_it.dart';
import 'package:secure_note/src/src.dart';

final di = GetIt.instance;

Future<void> setupDependencies() async {
  // Core Services - Singleton (created once and reused)
  di.registerSingleton<FirebaseService>(FirebaseService());

  // Data Services - Lazy Singleton (created when first accessed)
  di.registerLazySingleton<FirebaseAuthService>(
    () => FirebaseAuthService(di<FirebaseService>()),
  );

  // Repositories - Lazy Singleton
  di.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(di<FirebaseAuthService>()),
  );
}
