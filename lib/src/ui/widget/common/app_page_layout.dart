import 'package:flutter/material.dart';
import 'package:secure_note/src/src.dart';

class AppPageLayout extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool scrollable;

  const AppPageLayout({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.scrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(padding: padding, child: child);

    if (scrollable) {
      content = SingleChildScrollView(child: content);
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: AppColors.pageBackgroundGradient),
        ),
        child: SafeArea(
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: AppConstants.maxAppWidth,
                maxHeight: getHeight(context, 100),
              ),
              width: double.infinity,
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}
