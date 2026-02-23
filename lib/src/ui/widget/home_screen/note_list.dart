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
        NoteWidget(
          onTap: () {
            Logger.i('NoteWidget 1 tapped');
          },
        ),
        NoteWidget(
          onTap: () {
            Logger.i('NoteWidget 2 tapped');
          },
        ),
        NoteWidget(
          onTap: () {
            Logger.i('NoteWidget 3 tapped');
          },
        ),
        NoteWidget(
          onTap: () {
            Logger.i('NoteWidget 4 tapped');
          },
        ),
        NoteWidget(
          onTap: () {
            Logger.i('NoteWidget 5 tapped');
          },
        ),
      ],
    );
  }
}
