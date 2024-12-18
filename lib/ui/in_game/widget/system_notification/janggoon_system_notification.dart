import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/ui/in_game/controller/board_position_value.dart';

class JanggoonSystemNotification extends StatelessWidget {
  const JanggoonSystemNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: pieceSize * 2.45,
      bottom: pieceSize * 6.5,
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            color: inGameBlackColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: pieceSize, vertical: pieceSize / 2.5),
          child: Text(
            '장군!',
            style: GoogleFonts.songMyung(
              color: whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: pieceSize,
            ),
          ),
        )
            .animate()
            .fadeIn(
              duration: const Duration(seconds: 1),
            )
            .then()
            .fadeOut(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(seconds: 1),
            ),
      ),
    );
  }
}
