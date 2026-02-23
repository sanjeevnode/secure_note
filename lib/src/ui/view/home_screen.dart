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
      scrollable: false,
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
      floatingActionButton: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 600;
          if (!isSmallScreen) return const SizedBox.shrink();
          return FloatingActionButton(
            onPressed: () {},
            backgroundColor: AppColors.emeraldPrimary,
            child: const Icon(Icons.add, color: AppColors.white, size: 28),
          );
        },
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 970),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(HomeConstants.heading, style: AppTextStyle.text2xlSemibold),
              const SizedBox(height: 8),
              Text(
                HomeConstants.subHeading,
                style: AppTextStyle.textLgRegular.copyWith(
                  color: AppColors.grayDark,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SearchBox(),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add, size: 20),
                    label: const Text(HomeConstants.newSecretButton),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.emeraldPrimary,
                      textStyle: AppTextStyle.textMdSemibold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [Text("Note List")]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
