import 'package:flutter/material.dart';
import 'package:secure_note/src/ui/widget/common/app_page_layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const AppPageLayout(child: Column(children: [Text('Home Screen')]));
  }
}
