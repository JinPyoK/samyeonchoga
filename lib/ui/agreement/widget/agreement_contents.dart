import 'package:flutter/material.dart';

class AgreementContents extends StatelessWidget {
  const AgreementContents({
    super.key,
    required this.contents,
  });

  final String contents;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        contents,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
