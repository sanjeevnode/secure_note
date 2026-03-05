import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_note/src/src.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  Future<void> _initialize() async {
    final authCubit = context.read<AuthCubit>();
    final isAuthenticated = authCubit.isAuthenticated();
    if (!mounted) return;

    if (!isAuthenticated) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRouteNames.auth,
        (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppPageLayout(
      appBar: const CustomAppBar(
        showBackButton: true,
        title: ProfileConstants.title,
      ),
      child: Column(
        children: [
          const Text('Profile Screen'),
          const SizedBox(height: 20),
          const Text('This is the profile screen of the app.'),
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
