import 'dart:async';
import 'package:flutter/material.dart';
import 'package:secure_note/src/src.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class AppRouter {
  AppRouter._();

  static GoRouter router(AuthCubit authCubit) {
    return GoRouter(
      initialLocation: AppRouteNames.splash,
      refreshListenable: GoRouterRefreshStream(authCubit.stream),
      redirect: (context, state) async {
        final isAuth = authCubit.isAuthenticated();
        final location = state.matchedLocation;

        // Splash: determine initial destination
        if (location == AppRouteNames.splash) {
          if (isAuth) {
            // Set user if not already set (first launch)
            if (authCubit.state.user == null) {
              final user = authCubit.getCurrentUser();
              authCubit.setUser(user: user);
            }
            final isPinEnabled = await authCubit.isPinEnabled();
            if (!isPinEnabled) return AppRouteNames.pinSetup;
            return AppRouteNames.home;
          }
          return AppRouteNames.auth;
        }

        // Not authenticated → must be on auth screen
        if (!isAuth) {
          if (location != AppRouteNames.auth) return AppRouteNames.auth;
          return null;
        }

        // Authenticated on auth screen → redirect away
        if (location == AppRouteNames.auth) {
          final isPinEnabled = await authCubit.isPinEnabled();
          if (!isPinEnabled) return AppRouteNames.pinSetup;
          return AppRouteNames.home;
        }

        // Protected routes require pin
        if (location == AppRouteNames.home ||
            location == AppRouteNames.profile ||
            location == AppRouteNames.newSecretNote) {
          final isPinEnabled = await authCubit.isPinEnabled();
          if (!isPinEnabled) return AppRouteNames.pinSetup;
          return null;
        }

        // Pin setup: if already has pin → go home
        if (location == AppRouteNames.pinSetup) {
          final isPinEnabled = await authCubit.isPinEnabled();
          if (isPinEnabled) return AppRouteNames.home;
          return null;
        }

        return null;
      },
      routes: [
        GoRoute(
          path: AppRouteNames.splash,
          builder: (context, state) => const Splash(),
        ),
        GoRoute(
          path: AppRouteNames.auth,
          builder: (context, state) => const AuthScreen(),
        ),
        GoRoute(
          path: AppRouteNames.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: AppRouteNames.profile,
          builder: (context, state) => const Profile(),
        ),
        GoRoute(
          path: AppRouteNames.newSecretNote,
          builder: (context, state) => const NewSecretNote(),
        ),
        GoRoute(
          path: AppRouteNames.pinSetup,
          builder: (context, state) => const PinSetupScreen(),
        ),
      ],
      errorBuilder: (context, state) => const NotFoundPage(),
    );
  }
}
