import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';

class PieceJanggoonNotification extends StatelessWidget {
  const PieceJanggoonNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: inGameBlackColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Text(
        '장군!',
        style: TextStyle(
          color: whiteColor,
          fontWeight: FontWeight.bold,
          fontSize: 8 * hu,
        ),
      ),
    )
        .animate()
        .fade(duration: const Duration(seconds: 1))
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(
          delay: const Duration(seconds: 1),
          duration: const Duration(seconds: 1),
        );
  }
}
