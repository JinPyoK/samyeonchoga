import 'package:flutter/material.dart';
import 'package:samyeonchoga/ui/ad/controller/ad_id.dart';
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
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        SizedBox(height: 30 * hu),
        // AdBanner(
        //   adSize: AdSize(width: (300 * wu).toInt(), height: (100 * hu).toInt()),
        //   adUnitId: bannerId1,
        // ),
        // AdBanner(
        //   adSize: AdSize(width: (300 * wu).toInt(), height: (100 * hu).toInt()),
        //   adUnitId: bannerId2,
        // ),
        // AdBanner(
        //   adSize: AdSize(width: (300 * wu).toInt(), height: (100 * hu).toInt()),
        //   adUnitId: bannerId3,
        // ),
        AdReward(adUnitId: rewardId1),
        const SizedBox(height: 10),
        _renderCaution("광고를 올바르게 시청하지 않은 경우 보상이 주어지지 않을 수 있습니다."),
      ],
    );
  }
}

Padding _renderCaution(String text) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 10 * wu),
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
