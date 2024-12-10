import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';

class AdBanner extends StatefulWidget {
  const AdBanner({super.key, required this.adSize, required this.adUnitId});

  /// The requested size of the banner. Defaults to [AdSize.banner].
  final AdSize adSize;
  final String adUnitId;

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  /// The banner ad to show. This is `null` until the ad is actually loaded.
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  /// Loads a banner ad.
  void _loadAd() {
    final bannerAd = BannerAd(
      size: widget.adSize,
      adUnitId: widget.adUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );

    // Start loading.
    bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5 * wu, vertical: 5 * hu),
      child: SizedBox(
        width: widget.adSize.width.toDouble(),
        height: widget.adSize.height.toDouble(),
        child: _bannerAd == null
            // Nothing to render yet.
            ? const SizedBox()
            // The actual ad.
            : AdWidget(ad: _bannerAd!),
      ),
    );
  }
}
