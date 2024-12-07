import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';
import 'package:samyeonchoga/ui/common/controller/show_custom_dialog.dart';
import 'package:samyeonchoga/ui/home/widget/home_game_start_child.dart';
import 'package:samyeonchoga/ui/home/widget/home_help_child.dart';
import 'package:samyeonchoga/ui/home/widget/home_setting_child.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30 * hu),
            child: Column(
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
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50 * hu),
            child: Column(
              children: [
                OutlinedButton(
                  onPressed: () {
                    showCustomDialog(
                      context,
                      const HomeGameStartChild(),
                    );
                  },
                  child: const Text("게임 시작"),
                ),
                SizedBox(height: 20 * hu),
                OutlinedButton(
                  onPressed: () {
                    showCustomDialog(
                      context,
                      const HomeHelpChild(),
                    );
                  },
                  child: const Text("도움말"),
                ),
                SizedBox(height: 20 * hu),
                OutlinedButton(
                  onPressed: () {
                    showCustomDialog(
                      context,
                      const HomeSettingChild(),
                    );
                  },
                  child: const Text("환경 설정"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

final _textStyle = GoogleFonts.songMyung(
  fontWeight: FontWeight.bold,
  color: blackColor,
  fontSize: 42 * hu,
);
