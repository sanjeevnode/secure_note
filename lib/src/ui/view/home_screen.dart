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
      appBar: CustomAppBar(
        leading: const [AppIcon(size: 32), SizedBox(width: 12)],
        title: AppConstants.appName,
        actions: [
          BlocBuilder<AuthCubit, AuthCubitState>(
            builder: (context, state) {
              return Clickable(
                onTap: () {
                  if (state.user != null) {
                    Navigator.pushNamed(context, AppRouteNames.profile);
                  }
                },
                child: UserAvatar(userName: state.user?.displayName),
              );
            },
          ),
        ],
      ),
      child: Column(
        children: [
          const Text('Home Screen'),
          const SizedBox(height: 20),
          const Text('This is the home screen of the app.'),
          const SizedBox(height: 20),
          Text(
            context.read<AuthCubit>().getCurrentUser()?.displayName ??
                'No Name',
            style: AppTextStyle.text2xlBold,
          ),
        ],
      ),
    );
  }
}
