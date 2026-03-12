import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_note/src/src.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                    context.push(AppRouteNames.profile);
                  }
                },
                child: UserAvatar(userName: state.user?.displayName),
              );
            },
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 56,
        height: 56,
        child: FloatingActionButton(
          onPressed: () {
            context.push(AppRouteNames.newSecretNote);
          },
          backgroundColor: AppColors.emeraldPrimary,
          child: const Icon(Icons.add, color: AppColors.white, size: 28),
        ),
      ),
      fixedContentWidth: true,
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
          const SearchBox(),
          const SizedBox(height: 20),
          const Expanded(child: NoteList()),
        ],
      ),
    );
  }
}
