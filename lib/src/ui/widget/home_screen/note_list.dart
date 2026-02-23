import 'package:flutter/material.dart';
import 'package:secure_note/src/src.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var note in notes)
          NoteWidget(
            title: note["title"],
            date: note["date"],
            onTap: () {
              Navigator.pushNamed(context, AppRouteNames.newSecretNote);
            },
          ),
      ],
    );
  }
}

List<Map<String, dynamic>> notes = [
  {"title": "Meeting with Client", "date": DateTime(2024, 2, 20)},
  {"title": "Project Submission", "date": DateTime(2024, 3, 5)},
  {"title": "Team Standup", "date": DateTime(2024, 1, 15)},
  {"title": "Code Review", "date": DateTime(2024, 4, 10)},
  {"title": "Product Launch", "date": DateTime(2024, 5, 1)},
];
