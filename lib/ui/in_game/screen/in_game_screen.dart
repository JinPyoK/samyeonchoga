import 'package:flutter/material.dart';

class InGameScreen extends StatefulWidget {
  const InGameScreen({super.key});

  @override
  State<InGameScreen> createState() => _InGameScreenState();
}

class _InGameScreenState extends State<InGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("대국 스크린"),
      ),
    );
  }
}
