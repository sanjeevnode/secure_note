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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Text(HomeConstants.heading, style: AppTextStyle.text2xlSemibold),
          const SizedBox(height: 16),
          Text(
            HomeConstants.subHeading,
            style: AppTextStyle.textLgRegular.copyWith(
              color: AppColors.grayDark,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 240,
            child: TextFormField(
              textInputAction: TextInputAction.search,
              style: AppTextStyle.textMdRegular.copyWith(
                color: AppColors.grayDarker,
              ),
              decoration: const InputDecoration(
                hintText: HomeConstants.searchText,
                fillColor: AppColors.white,
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.grayIcon,
                  size: 20,
                ),
                // suffixIcon: suffixIcon,
              ),
            ),
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(children: [Text("Note List")]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
