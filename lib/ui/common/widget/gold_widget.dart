import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoldWidget extends StatelessWidget {
  const GoldWidget({
    super.key,
    required this.gold,
  });

  final int gold;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(gold.toString()),
        const SizedBox(width: 10),
        const FaIcon(
          FontAwesomeIcons.coins,
          color: Colors.amber,
        ),
      ],
    );
  }
}
