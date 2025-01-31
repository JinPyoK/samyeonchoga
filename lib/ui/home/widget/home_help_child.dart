import 'package:flutter/material.dart';
import 'package:samyeonchoga/core/constant/asset_path.dart';
import 'package:samyeonchoga/ui/common/controller/screen_size.dart';
import 'package:samyeonchoga/ui/common/controller/show_custom_snackbar.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
            '사면초가는 사방에서 초나라 노래가 흘러나온다는 뜻으로, 사면이 모두 적에게 포위되거나, 누구의 지지나 도움도 받을 수 없어 고립된 상태를 이르는 말입니다.'),
        _renderDescription(
            '이 게임은 한나라의 기물이 계속해서 부활하며 초나라(유저)의 왕을 노릴 것입니다. 유저는 끊임없이 쏟아져 나오는 한나라 병사들을 막아야 하며, 끝내 버티지 못하고 사면초가의 상황을 맞이할 것입니다.'),
        _renderDescription('최대한 오래 버티세요!'),
        _renderTitle('2. 게임 시작'),
        _renderDescription(
            '유저는 초나라 진영에서 플레이 하고, 최소 0골드, 최대 3000골드를 가지고 게임을 시작할 수 있습니다.'),
        _renderDescription(
            '게임 시작 버튼을 누르신 후 포진을 자유롭게 선택하여 주시면 됩니다. 한나라의 포진은 랜덤입니다.'),
        _renderTitle('3. 대국'),
        _renderDescription(
            '20수 마다 한나라가 강해지며, 총 5단계까지 강화됩니다. 한나라가 강해질 수록 한나라의 알고리즘이 더욱 깊어지며, 부활 빈도가 증가합니다.'),
        _renderDescription('한나라의 기물이 왕을 바로 취할 수 있는 자리에 부활할 수 있으니 조심하세요.'),
        _renderDescription(
            '대국 도중에 앱을 강제 종료 하지 마세요. 라운드, 골드 등 진행했던 내용이 모두 사라집니다.'),
        _renderTitle('4. 골드'),
        _renderDescription('기물을 부활시키거나 처형하기 위해 골드가 필요합니다.'),
        _renderDescription('대국 도중 한나라 기물을 취하면 소량의 골드를 획득합니다.'),
        _renderDescription('게임 종료 이후 남은 골드는 모두 돌려받습니다.'),
        _renderDescription('앱을 삭제하면 열심히 모은 골드는 사라지므로 주의해주세요!'),
        _renderDescription('아래 Ad 탭에서 광고를 시청하시면 1000골드를 보상으로 받으실 수 있습니다.'),
        _renderTitle('5. 기물 부활'),
        _renderDescription('초나라의 기물 부활 개수는 최대를 넘을 수 없으며, 골드가 소모됩니다.'),
        _renderDescription(
            '졸: 5개, 20골드\n상: 2개, 30골드\n사: 2개, 30골드\n마: 2개, 50골드\n포: 2개, 70골드\n차: 2개, 130골드'),
        _renderTitle('6. 기물 처형'),
        _renderDescription('초나라 또는 한나라 기물을 즉시 처형할 수 있습니다. 300골드를 소모합니다. '),
        _renderTitle('7. 게임 종료'),
        _renderDescription(
            '초나라의 왕이 한나라의 기물로부터 취해졌거나 한나라 기물의 수가 50을 초과하면 게임이 종료됩니다.'),
        _renderDescription(
            '대국 도중에 게임을 임시 저장 및 종료할 수 있고, 저장한 게임을 나중에 다시 시작할 수 있습니다.'),
        _renderDescription('골드와 마찬가지로, 앱을 삭제하면 저장했던 게임이 사라집니다.'),
        _renderTitle('8. 랭크'),
        _renderDescription('게임이 종료되었을 때, 유저의 최종 착수 횟수를 랭크에 등록하실 수 있습니다.'),
        _renderDescription('랭크는 최대 100위까지 기록되며, 아래 Rank 탭에서 확인하실 수 있습니다.'),
        _renderTitle('9. 개인 정보 처리 방침 및 이용 약관'),
        TextButton(
            onPressed: () async {
              try {
                await launchUrlString(
                    'https://doc-hosting.flycricket.io/samyeonchoga-privacy-policy/8969df59-6b0b-4697-ba23-406c3978aa1b/privacy');
              } catch (_, __) {
                if (context.mounted) {
                  showCustomSnackBar(context, '웹사이트에 접속할 수 없습니다.');
                }
              }
            },
            child: const Text("개인 정보 처리 방침")),
        TextButton(
            onPressed: () async {
              try {
                await launchUrlString(
                    'https://doc-hosting.flycricket.io/samyeonchoga-terms-of-use/447c5e07-7c85-4336-9b16-ca31e569ea24/terms');
              } catch (_, __) {
                if (context.mounted) {
                  showCustomSnackBar(context, '웹사이트에 접속할 수 없습니다.');
                }
              }
            },
            child: const Text("이용 약관")),
        _renderTitle('10. 라이센스'),
        _renderDescription('기물과 장기판 이미지는 제가 직접 그렸습니다.'),
        _renderDescription('앱 로고 및 도움말 상단 이미지는 AI를 통해 생성하였습니다.'),
        _renderDescription('효과음: Pixabay -> TanwerAman, freesound_community'),
        _renderDescription('골드, 트토피 아이콘: Font Awesome Free Icons'),
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
