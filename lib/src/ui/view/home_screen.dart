import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_note/src/src.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AppPageLayout(
      child: Column(
        children: [
          const Text('Home Screen'),
          const SizedBox(height: 20),
          const Text('This is the home screen of the app.'),
          const SizedBox(height: 20),
          GradientButton(
            label: 'Logout',
            onSubmit: () async {
              await context.read<AuthCubit>().logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRouteNames.auth,
                (_) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
