import 'package:flutter/material.dart';
import 'package:secure_note/src/src.dart';

class UpdatePin extends StatefulWidget {
  const UpdatePin({super.key});

  @override
  State<UpdatePin> createState() => _UpdatePinState();
}

class _UpdatePinState extends State<UpdatePin> {
  @override
  Widget build(BuildContext context) {
    return AppPageLayout(
      appBar: const CustomAppBar(title: "Update PIN", showBackButton: true),
      fixedContentWidth: true,
      child: Column(
        children: [
          Text("Update PIN", style: AppTextStyle.textLgSemibold),
          const SizedBox(height: 20),
          TextFormField(
            maxLines: 1,
            decoration: const InputDecoration(
              hintText: "Enter new PIN",
              fillColor: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
