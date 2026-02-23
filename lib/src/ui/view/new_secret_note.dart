import 'package:flutter/material.dart';
import 'package:secure_note/src/src.dart';

class NewSecretNote extends StatefulWidget {
  const NewSecretNote({super.key});

  @override
  State<NewSecretNote> createState() => _NewSecretNoteState();
}

class _NewSecretNoteState extends State<NewSecretNote> {
  @override
  Widget build(BuildContext context) {
    return AppPageLayout(
      appBar: const CustomAppBar(title: "New Secret", showBackButton: true),
      child: Column(
        children: [
          Text("New Secret Note", style: AppTextStyle.textLgSemibold),
          const SizedBox(height: 20),
          TextFormField(
            maxLines: 10,
            decoration: const InputDecoration(
              hintText: "Write your secret note here...",
              fillColor: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
