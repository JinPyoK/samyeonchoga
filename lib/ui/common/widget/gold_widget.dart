import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samyeonchoga/core/constant/color.dart';

class GoldWidget extends StatelessWidget {
  const GoldWidget({
    super.key,
    required this.gold,
    this.goldTextColor = blackColor,
  });

  final int gold;
  final Color goldTextColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedFlipCounter(
          value: gold,
          duration: const Duration(milliseconds: 500),
          textStyle: TextStyle(color: goldTextColor),
        ),
        const SizedBox(width: 10),
        const FaIcon(FontAwesomeIcons.coins, color: Colors.amber),
      ],
    );
  }
}
