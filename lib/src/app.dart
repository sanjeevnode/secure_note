import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_note/src/src.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(authRepository: di<AuthRepository>()),
        ),
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatefulWidget {
  const _AppView();

  @override
  State<_AppView> createState() => __AppViewState();
}

class __AppViewState extends State<_AppView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.standard,
      scaffoldMessengerKey: Toast.scaffoldKey,
      navigatorKey: AppRouter.navigationKey,
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [AppRouter.routeObserver],
      builder: (context, child) {
        return CustomBehaviour(child: child!);
      },
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouteNames.splash,
    );
  }
}
