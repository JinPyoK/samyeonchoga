import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/ui/in_game/controller/board_position_value.dart';

class ErrorSystemNotification extends StatelessWidget {
  const ErrorSystemNotification({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    double leftPadding = pieceSize * 1.65;

    if (errorMessage == '기물의 수가 최대입니다') {
      leftPadding = pieceSize * 1.2;
    }

    return Positioned(
      left: leftPadding,
      bottom: pieceSize,
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            color: inGameBlackColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: pieceSize, vertical: pieceSize / 2),
          child: Text(
            errorMessage,
            style: GoogleFonts.songMyung(
              color: whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: pieceSize / 2,
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
