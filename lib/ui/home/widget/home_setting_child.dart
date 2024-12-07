import 'package:flutter/material.dart';

class HomeSettingChild extends StatefulWidget {
  const HomeSettingChild({super.key});

  @override
  State<HomeSettingChild> createState() => _HomeSettingChildState();
}

class _HomeSettingChildState extends State<HomeSettingChild> {
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () {}, child: const Text("로그아웃"));
  }
}
