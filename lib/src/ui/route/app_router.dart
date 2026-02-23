import 'package:flutter/material.dart';
import 'package:secure_note/src/src.dart';

class AppRouter {
  static final navigationKey = GlobalKey<NavigatorState>();

  static final RouteObserver<PageRoute<dynamic>> routeObserver =
      RouteObserver<PageRoute<dynamic>>();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.splash:
        return _buildMaterialPageRoute(const Splash(), name: settings.name);

      case AppRouteNames.auth:
        return _buildMaterialPageRoute(const AuthScreen(), name: settings.name);

      case AppRouteNames.home:
        return _buildMaterialPageRoute(const HomeScreen(), name: settings.name);

      case AppRouteNames.profile:
        return _buildMaterialPageRoute(const Profile(), name: settings.name);

      case AppRouteNames.newSecretNote:
        return _buildMaterialPageRoute(
          const NewSecretNote(),
          name: settings.name,
        );

      default:
        return _buildMaterialPageRoute(const Scaffold());
    }
  }

  static Route<dynamic> _buildMaterialPageRoute(Widget widget, {String? name}) {
    return MaterialPageRoute(
      builder: (_) => widget,
      settings: RouteSettings(name: name),
    );
  }
}
