import 'package:flutter/material.dart';
import 'package:samyeonchoga/ui/common/controller/screen_size.dart';

class AgreementContentsBullet extends StatelessWidget {
  const AgreementContentsBullet({
    super.key,
    required this.contents,
  });

  final String contents;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '●',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 260 * wu,
            child: Text(
              contents,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
