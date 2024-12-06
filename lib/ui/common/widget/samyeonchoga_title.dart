import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';

class SamyeonchogaTitle extends StatelessWidget {
  const SamyeonchogaTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "四 面 楚 歌",
          style: _textStyle,
        ),
        Text(
          "사 면 초 가",
          style: _textStyle,
        ),
      ],
    );
  }
}

final _textStyle = GoogleFonts.songMyung(
  fontWeight: FontWeight.bold,
  color: blackColor,
  fontSize: 42 * hu,
);
