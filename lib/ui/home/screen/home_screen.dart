import 'package:flutter/material.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';
import 'package:samyeonchoga/ui/common/controller/show_custom_dialog.dart';
import 'package:samyeonchoga/ui/common/widget/samyeonchoga_title.dart';
import 'package:samyeonchoga/ui/home/widget/home_game_start_child.dart';
import 'package:samyeonchoga/ui/home/widget/home_help_child.dart';
import 'package:samyeonchoga/ui/home/widget/home_setting_child.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 100 * hu),
          child: const SamyeonchogaTitle(),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 50 * hu),
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
    );
  }
}
