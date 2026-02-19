import 'dart:async';
import 'package:flutter/material.dart';
import 'package:secure_note/src/src.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.debounceDuration = const Duration(milliseconds: 300),
  });

  @override
  State<SearchBox> createState() => _SearchBoxState();
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final Duration debounceDuration;
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounceTimer;

  void onChange(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(widget.debounceDuration, () {
      widget.onChanged?.call(value);
    });
  }

  void onSubmit(String value) {
    _debounceTimer?.cancel();
    widget.onSubmitted?.call(value);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: TextFormField(
        controller: widget.controller ?? _controller,
        onChanged: onChange,
        onFieldSubmitted: onSubmit,
        textInputAction: TextInputAction.search,
        style: AppTextStyle.textMdRegular.copyWith(color: AppColors.grayDarker),
        decoration: const InputDecoration(
          hintText: HomeConstants.searchText,
          fillColor: AppColors.white,
          prefixIcon: Icon(Icons.search, color: AppColors.grayIcon, size: 20),
          // suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
