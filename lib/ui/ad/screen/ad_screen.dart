import 'package:flutter/material.dart';
import 'package:samyeonchoga/ui/ad/widget/ad_banner.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';

class AdScreen extends StatelessWidget {
  const AdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            "광고",
            style: TextStyle(
              fontSize: 36 * hu,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const AdBanner(),
        const AdBanner(),
        Padding(
          padding: const EdgeInsets.all(18),
          child: ElevatedButton(
            onPressed: () {},
            child: const Text("광고 시청 후 1000골드 획득"),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _renderCaution("골드는 유저 여러분의 스마트폰 또는 PC 기기에 종속됩니다."),
            _renderCaution("앱을 삭제하면 골드는 초기상태로 초기화됩니다."),
            _renderCaution("광고 시청 도중 앱이 종료되면 보상이 주어지지 않습니다."),
          ],
        )
      ],
    );
  }
}

Padding _renderCaution(String text) => Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 8),
      child: Text(
        '* $text',
        style: const TextStyle(color: Colors.black45),
      ),
    );
