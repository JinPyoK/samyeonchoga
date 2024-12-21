import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:samyeonchoga/repository/store_version/store_version.dart';

Future<bool?> compareVersionWithStoreUploadedVersion() async {
  String? storeVersion;

  if (Platform.isAndroid) {
    storeVersion = await androidStoreVersion();
  } else {
    storeVersion = await iosStoreVersion();
  }

  /// 스토어애 등록된 버전을 불러오지 못했을 때
  if (storeVersion == null) {
    return null;
  }

  final packageInfo = await PackageInfo.fromPlatform();

  final appVersion = packageInfo.version;

  return storeVersion != appVersion;
}
