import 'package:flutter/material.dart';

class HomeSettingChild extends StatefulWidget {
  const HomeSettingChild({super.key});

  @override
  State<HomeSettingChild> createState() => _HomeSettingChildState();
}

class _HomeSettingChildState extends State<HomeSettingChild> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("환경 설정"),
        Text("장군 bgm, 효과음 소리 조절"),
      ],
    );
  }
}
