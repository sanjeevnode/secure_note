import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_note/src/src.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPageLayout(
      appBar: const CustomAppBar(
        showBackButton: true,
        title: ProfileConstants.title,
      ),
      fixedContentWidth: true,
      child: Column(
        children: [
          const Text('Profile Screen'),
          const SizedBox(height: 20),
          const Text('This is the profile screen of the app.'),
          const SizedBox(height: 20),
          GradientButton(
            label: 'Update PIN',
            onSubmit: () async {
              context.push(AppRouteNames.updatePin);
            },
          ),
          GradientButton(
            label: 'Logout',
            onSubmit: () async {
              await context.read<AuthCubit>().logout();
              if (!context.mounted) return;
              context.go(AppRouteNames.auth);
            },
          ),
        ],
      ),
    );
  }
}
