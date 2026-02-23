import 'package:flutter/material.dart';
import 'package:secure_note/src/src.dart';

class AppPageLayout extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool scrollable;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;

  const AppPageLayout({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.scrollable = true,
    this.appBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
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
              child: scrollable
                  ? LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                              minWidth: constraints.maxWidth,
                            ),
                            child: Padding(padding: padding, child: child),
                          ),
                        );
                      },
                    )
                  : SizedBox.expand(
                      child: Padding(padding: padding, child: child),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
