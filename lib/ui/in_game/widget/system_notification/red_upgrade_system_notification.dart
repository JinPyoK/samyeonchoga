import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/ui/in_game/controller/board_position_value.dart';

class RedUpgradeSystemNotification extends StatelessWidget {
  const RedUpgradeSystemNotification({super.key, required this.level});

  final int level;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          color: inGameBlackColor.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: pieceSize, vertical: pieceSize / 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '한나라 알고리즘',
              style: GoogleFonts.songMyung(
                color: whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: pieceSize / 2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    level.toString(),
                    style: GoogleFonts.songMyung(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: pieceSize,
                    ),
                  ),
                ),
                Text(
                  '단계',
                  style: GoogleFonts.songMyung(
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: pieceSize / 2,
                  ),
                ),
              ],
            ),
          ],
        ),
      )
          .animate()
          .fadeIn(
            duration: const Duration(seconds: 1),
          )
          .then()
          .shimmer(
            delay: const Duration(milliseconds: 500),
            duration: const Duration(seconds: 1),
          )
          .then()
          .fadeOut(
            delay: const Duration(milliseconds: 500),
            duration: const Duration(seconds: 1),
          ),
    );
  }
}
