import 'package:flutter/material.dart';
import 'package:samyeonchoga/core/constant/asset_path.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';

class HomeHelpChild extends StatelessWidget {
  const HomeHelpChild({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(imageAppLogoPath),
        const SizedBox(height: 30),
        _renderTitle('1. 사면초가'),
        _renderDescription(
            '사면초가는 사방에서 초나라 노래가 흘러나온다는 뜻으로, 사면이 모두 적에게 포위되거나, 누구의 지지나 도움도 받을 수 없어 고립된 상태를 이르는 말입니다. 이 게임은 초나라의 기물이 계속해서 부활하며 한나라(유저)의 왕을 노릴 것입니다. 유저는 끊임없이 쏟아져 나오는 초나라 병사들을 막아야 하며, 끝내 버티지 못하고 사면초가의 상황을 맞이할 것입니다. 골드를 이용하여 기물을 부활 및 처형할 수 있습니다. 최대한 오래 버티세요!'),
        _renderTitle('2. 골드'),
        _renderDescription(
            '기물 부활 및 처형을 이용하기 위해 골드가 필요합니다. 초나라 기물을 취하면 소량의 골드를 획득합니다. 게임 종료 이후 남은 골드는 모두 돌려받습니다. 앱을 삭제하면 열심히 모은 골드는 사라지므로 주의해주세요! 아래 Ad 탭에서 광고를 시청하시면 1000골드를 보상으로 받으실 수 있습니다.'),
        _renderTitle('3. 게임 시작'),
        _renderDescription(
            '최소 0골드, 최대 3000골드로 게임을 시작할 수 있습니다. 유저는 한나라 진영에서 플레이 합니다. 포진을 자유롭게 선택하여 주시면 됩니다. 초나라의 포진은 랜덤입니다.'),
        _renderTitle('4. 대국'),
        _renderDescription(
            'Round의 정의는 초나라 착수 한 번, 이후 한나라(유저) 착수 한 번이 1 Round입니다. 10 Round마다 초나라가 강해지며, 총 5단계까지 강화됩니다. 초나라가 강해질 수록 초나라의 알고리즘이 더욱 깊어지며, 부활 빈도가 증가합니다.'),
        _renderTitle('5. 기물 부활'),
        _renderDescription(
            '한나라의 기물 부활 개수는 최대를 넘을 수 없으며, 골드가 소모됩니다.\n병: 5개, 20골드\n상: 2개, 30골드\n사: 2개, 30골드\n마: 2개, 50골드\n포: 2개, 70골드\n차: 2개, 130골드'),
        _renderTitle('6. 기물 처형'),
        _renderDescription('초나라 또는 한나라 기물을 즉시 처형할 수 있습니다. 300골드를 소모합니다. '),
        _renderTitle('7. 게임 종료'),
        _renderDescription(
            '한나라의 왕이 초나라의 기물로부터 취해졌을 때 게임이 종료됩니다. 도중에 게임을 저장한 후, 추후 저장했던 게임을 다시 시작할 수 있습니다. 골드와 마찬가지로, 앱을 삭제하면 저장했던 게임이 사라집니다.'),
        _renderTitle('8. 랭크'),
        _renderDescription(
            '한나라의 왕이 초나라의 기물로부터 취해져서 게임이 종료되었을 때, 유저의 최종 Round 기록을 랭크에 등록하실 수 있습니다. 랭크는 최대 100위까지 기록되며, 아래 Rank 탭에서 확인하실 수 있습니다.'),
        _renderTitle('9. 애셋 출처'),
        _renderDescription(
            '장기판, 기물은 제가 직접 그렸습니다.\n효과음: Pixabay -> freesound_community, TanwerAman\n폰트: 나눔고딕체, 송명체\n앱 로고: AI 이미지'),
      ],
    );
  }
}

Padding _renderTitle(String title) => Padding(
      padding: EdgeInsets.only(bottom: 5 * hu),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );

Padding _renderDescription(String description) => Padding(
      padding: EdgeInsets.only(bottom: 10 * hu),
      child: Text(description),
    );
