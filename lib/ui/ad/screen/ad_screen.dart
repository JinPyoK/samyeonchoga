import 'package:flutter/material.dart';
import 'package:samyeonchoga/ui/ad/controller/ad_id.dart';
import 'package:samyeonchoga/ui/ad/widget/ad_reward.dart';
import 'package:samyeonchoga/ui/common/controller/screen_size.dart';

class AdScreen extends StatefulWidget {
  const AdScreen({super.key});

  @override
  State<AdScreen> createState() => _AdScreenState();
}

class _AdScreenState extends State<AdScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20 * wu),
          child: Text(
            "광고",
            style: TextStyle(
              fontSize: 36 * hu,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // SizedBox(height: 10 * hu),
        // AdBanner(
        //   adSize: AdSize(width: (300 * wu).toInt(), height: (100 * hu).toInt()),
        //   adUnitId: bannerUnitId,
        // ),
        SizedBox(height: 20 * hu),
        Padding(
          padding: EdgeInsets.all(12 * hu),
          child: AdReward(adUnitId: rewardUnitId),
        ),
        _renderCaution("광고를 올바르게 시청하지 않은 경우 보상이 주어지지 않을 수 있습니다."),
        _renderCaution("앱을 삭제하면 골드가 사라집니다."),
        _renderCaution("자세한 내용은 Home 탭의 도움말 버튼을 눌러보세요."),
      ],
    );
  }
}

Padding _renderCaution(String text) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 10 * wu, vertical: 5 * hu),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '* ',
            style: TextStyle(color: Colors.black54),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
