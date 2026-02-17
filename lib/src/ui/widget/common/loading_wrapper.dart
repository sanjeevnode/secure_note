import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:secure_note/src/src.dart';

// Widget for wrapping content with a loading overlay
class LoadingWrapper extends StatefulWidget {
  // Constructor for LoadingWrapper
  const LoadingWrapper({
    required this.child,
    super.key,
    this.isLoading = false,
  });

  final Widget child;
  final bool isLoading;

  @override
  // Creates the mutable state for this widget
  State<LoadingWrapper> createState() => _LoadingWrapperState();
}

// State class for LoadingWrapper
class _LoadingWrapperState extends State<LoadingWrapper> {
  @override
  // Initializes the state
  void initState() {
    super.initState();
  }

  @override
  // Builds the loading wrapper UI
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.isLoading)
          Stack(
            children: [
              GestureDetector(
                onTap: () {},
                behavior: HitTestBehavior.opaque,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(color: AppColors.white.withAlpha(12)),
                ),
              ),
              const Center(child: LoadingWidget(size: 50)),
            ],
          ),
      ],
    );
  }
}
