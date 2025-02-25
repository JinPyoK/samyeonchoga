import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/ui/in_game/controller/board_position_value.dart';

class RedOnTheRopesSystemNotification extends StatelessWidget {
  const RedOnTheRopesSystemNotification({super.key});

  @override
  Widget build(BuildContext context) {
    double leftPadding = pieceSize * 0.65;

    return Positioned(
      left: leftPadding,
      bottom: pieceSize,
      child: IgnorePointer(
        child: Container(
              decoration: BoxDecoration(
                color: inGameBlackColor.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: pieceSize,
                vertical: pieceSize / 3,
              ),
              child: Text(
                '사방에서 초나라의 노래가 들려온다',
                style: GoogleFonts.songMyung(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: pieceSize / 2.5,
                ),
              ),
            )
            .animate()
            .fadeIn(duration: const Duration(seconds: 2))
            .then()
            .fadeOut(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(seconds: 2),
            ),
      ),
    );
  }
}
