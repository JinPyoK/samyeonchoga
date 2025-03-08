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
    return Align(
      alignment: Alignment.bottomCenter,
      child: IgnorePointer(
        child: Padding(
          padding: EdgeInsets.only(bottom: pieceSize),
          child: Container(
                decoration: BoxDecoration(
                  color: inGameBlackColor.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: pieceSize,
                  vertical: pieceSize / 3,
                ),
                width: pieceSize * 8,
                height: pieceSize * 1.5,
                child: FittedBox(
                  child: Text(
                    errorMessage,
                    style: GoogleFonts.songMyung(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: const Duration(seconds: 1))
              .then()
              .fadeOut(
                delay: const Duration(milliseconds: 500),
                duration: const Duration(seconds: 1),
              ),
        ),
      ),
    );
  }
}
