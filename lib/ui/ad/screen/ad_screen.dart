import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:samyeonchoga/ui/ad/controller/ad_id.dart';
import 'package:samyeonchoga/ui/ad/widget/ad_banner.dart';
import 'package:samyeonchoga/ui/ad/widget/ad_reward.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';

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
    return SingleChildScrollView(
      child: Column(
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
          AdBanner(
            adSize:
                AdSize(width: (300 * wu).toInt(), height: (100 * hu).toInt()),
            adUnitId: bannerId1,
          ),
          AdBanner(
            adSize:
                AdSize(width: (300 * wu).toInt(), height: (100 * hu).toInt()),
            adUnitId: bannerId2,
          ),
          AdBanner(
            adSize:
                AdSize(width: (300 * wu).toInt(), height: (100 * hu).toInt()),
            adUnitId: bannerId3,
          ),
          AdReward(adUnitId: rewardId1),
          _renderCaution("골드는 유저 여러분의 스마트폰 또는 PC 기기에 종속됩니다."),
          _renderCaution("앱을 삭제하면 보유하고 있던 골드가 사라집니다."),
          _renderCaution("광고를 올바르게 시청하지 않은 경우 보상이 주어지지 않을 수 있습니다.")
        ],
      ),
    );
  }
}

Padding _renderCaution(String text) => Padding(
      padding: EdgeInsets.symmetric(vertical: 5 * hu, horizontal: 10 * wu),
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
