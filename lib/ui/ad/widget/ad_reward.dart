import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:samyeonchoga/provider/gold/gold_entity.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';
import 'package:samyeonchoga/ui/common/controller/show_custom_snackbar.dart';
import 'package:samyeonchoga/ui/common/controller/util_function.dart';

class AdReward extends StatefulWidget {
  const AdReward({super.key, required this.adUnitId});

  final String adUnitId;

  @override
  State<AdReward> createState() => _AdRewardState();
}

class _AdRewardState extends State<AdReward> {
  RewardedAd? _rewardedAd;

  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }

  void _loadAd() {
    RewardedAd.load(
        adUnitId: widget.adUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          /// Called when an ad is successfully received.
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(

                /// Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},

                /// Called when an impression occurs on the ad.
                onAdImpression: (ad) {},

                /// Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  /// Dispose the ad here to free resources.
                  ad.dispose();
                },

                /// Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  /// Dispose the ad here to free resources.
                  ad.dispose();
                },

                /// Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            // Keep a reference to the ad so you can show it later.
            _rewardedAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (_) {
            showCustomSnackBar(context, '광고 로드 실패');
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10 * wu),
      child: ElevatedButton(
        onPressed: () {
          _loadAd();

          if (_rewardedAd == null) {
            showCustomSnackBar(context, '잠시 후 다시 시도해 주세요');
          } else {
            try {
              _rewardedAd!.show(
                onUserEarnedReward: (_, __) {
                  myGold.gold += 1000;
                  if (setStateGold != null) {
                    setStateGold!(() {});
                  }
                  unawaited(myGold.writeGold());
                },
              );
            } catch (_) {
              showCustomSnackBar(context, '잠시 후 다시 시도해 주세요');
            }
          }
        },
        child: const Text("광고 시청 후 1000골드 획득"),
      ),
    );
  }
}
