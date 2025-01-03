import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:samyeonchoga/core/constant/native_key.dart';

/// 플랫폼별 배너 아이디
final bannerPlatformTestId =
    Platform.isAndroid ? aosBannerTestId : iosBannerTestId;
final bannerPlatformId1 = Platform.isAndroid ? aosBannerId1 : iosBannerId1;
final bannerPlatformId2 = Platform.isAndroid ? aosBannerId2 : iosBannerId2;
final bannerPlatformId3 = Platform.isAndroid ? aosBannerId3 : iosBannerId3;

/// 플랫폼별 리워드 아이디
final rewardPlatformTestId =
    Platform.isAndroid ? aosRewardTestId : iosRewardTestId;
final rewardPlatformId1 = Platform.isAndroid ? aosRewardId1 : iosRewardId1;

/// 릴리스 모드이면 실제 ID 표시
final bannerId1 = kReleaseMode ? bannerPlatformId1 : bannerPlatformTestId;
final bannerId2 = kReleaseMode ? bannerPlatformId2 : bannerPlatformTestId;
final bannerId3 = kReleaseMode ? bannerPlatformId3 : bannerPlatformTestId;

final rewardId1 = kReleaseMode ? rewardPlatformId1 : rewardPlatformTestId;
