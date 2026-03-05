import 'dart:math';
import 'package:flutter/material.dart';
import 'package:secure_note/src/src.dart';

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({super.key});

  @override
  State<NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.pageBackgroundGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Floating Icon
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, sin(_controller.value * pi * 2) * 10),
                      child: child,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: AppColors.primaryGradient,
                      ),
                      borderRadius: BorderRadius.circular(
                        AppConstants.appBorderRadius * 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.tealPrimary.withAlpha(60),
                          blurRadius: 30,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.search_off_rounded,
                      size: 64,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                /// 404 Text
                Text(
                  "404",
                  style: AppTextStyle.textXlSemibold.copyWith(
                    fontSize: 72,
                    color: AppColors.grayDarkest,
                  ),
                ),

                const SizedBox(height: 8),

                /// Title
                Text(
                  "Page Not Found",
                  style: AppTextStyle.textXlSemibold.copyWith(
                    color: AppColors.grayDarker,
                  ),
                ),

                const SizedBox(height: 12),

                /// Description
                Text(
                  "The page you're looking for doesn't exist or has been moved.",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.textMdRegular.copyWith(
                    color: AppColors.grayMedium,
                  ),
                ),

                const SizedBox(height: 32),

                /// Button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRouteNames.home,
                      (_) => false,
                    );
                  },
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: const Text("Home"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
