import 'package:flutter/material.dart';

class HomeGameStartChild extends StatefulWidget {
  const HomeGameStartChild({super.key});

  @override
  State<HomeGameStartChild> createState() => _HomeGameStartChildState();
}

class _HomeGameStartChildState extends State<HomeGameStartChild> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("골드 선택"),
        Text("포진 선택"),
      ],
    );
  }
}
