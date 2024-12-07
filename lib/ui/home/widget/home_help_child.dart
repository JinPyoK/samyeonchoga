import 'package:flutter/material.dart';

class HomeHelpChild extends StatelessWidget {
  const HomeHelpChild({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("게임 시스템 이해(골드 사용, 초나라 부활 및 디펜스,  게임 종료 후 랭크 등록 가능)"),
        Text(
            "게임 플레이 방법(장기와 똑같은 룰, 아래 버튼 눌러서 부활 및 처형, 한나라 포진 선택, 게임 종료 및 저장 가능"),
      ],
    );
  }
}
