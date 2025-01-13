import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/provider/in_game/in_game_save_entity.dart';
import 'package:samyeonchoga/ui/common/controller/screen_size.dart';
import 'package:samyeonchoga/ui/common/controller/show_custom_dialog.dart';
import 'package:samyeonchoga/ui/home/widget/home_game_start_child.dart';
import 'package:samyeonchoga/ui/home/widget/home_help_child.dart';
import 'package:samyeonchoga/ui/home/widget/home_setting_child.dart';
import 'package:samyeonchoga/ui/in_game/screen/in_game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
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
        Column(
          children: [
            _renderButton(context, '게임 시작', const HomeGameStartChild(),
                defaultAction: false),
            SizedBox(height: 20 * hu),
            _renderButton(context, '도움말', const HomeHelpChild()),
            SizedBox(height: 20 * hu),
            _renderButton(context, '환경 설정', const HomeSettingChild()),
          ],
        ),
        Container(), // spaceAround를 위한 더미 컨테이너
      ],
    );
  }
}

final _textStyle = GoogleFonts.songMyung(
  fontWeight: FontWeight.bold,
  color: blackColor,
  fontSize: 42 * hu,
);

OutlinedButton _renderButton(BuildContext context, String text, Widget child,
        {bool defaultAction = true}) =>
    OutlinedButton(
      onPressed: () async {
        /// 앱 시작시 저장된 게임 있는지 확인
        inGameSave = await inGameSave?.readInGameSave();

        if (context.mounted) {
          if (defaultAction == false) {
            if (inGameSave != null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const InGameScreen(gameHadSaved: true)));
            } else {
              showCustomDialog(context, child, defaultAction: defaultAction);
            }
          } else {
            showCustomDialog(context, child, defaultAction: defaultAction);
          }
        }
      },
      style: OutlinedButton.styleFrom(fixedSize: Size(100 * wu, 40 * hu)),
      child: Text(text),
    );
