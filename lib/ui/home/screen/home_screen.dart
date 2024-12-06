import 'package:flutter/material.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';
import 'package:samyeonchoga/ui/common/controller/show_custom_dialog.dart';
import 'package:samyeonchoga/ui/common/widget/samyeonchoga_title.dart';
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
                    const Column(
                      children: [
                        Text("골드 선택"),
                        Text("포진 선택"),
                      ],
                    ),
                  );
                },
                child: const Text("게임 시작"),
              ),
              SizedBox(height: 20 * hu),
              OutlinedButton(
                onPressed: () {
                  showCustomDialog(
                    context,
                    const Column(
                      children: [
                        Text(
                            "게임 시스템 이해(골드 사용, 초나라 부활 및 디펜스,  게임 종료 후 랭크 등록 가능)"),
                        Text(
                            "게임 플레이 방법(장기와 똑같은 룰, 아래 버튼 눌러서 부활 및 처형, 한나라 포진 선택, 게임 종료 및 저장 가능"),
                      ],
                    ),
                  );
                },
                child: const Text("도움말"),
              ),
              SizedBox(height: 20 * hu),
              OutlinedButton(
                onPressed: () {
                  showCustomDialog(
                    context,
                    const Column(
                      children: [
                        Text("환경 설정"),
                        Text("장군 bgm, 효과음 소리 조절 / 로그아웃"),
                        HomeSettingChild(),
                      ],
                    ),
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
