import 'package:flutter/material.dart';
import 'package:samyeonchoga/ui/common/widget/image_assets.dart';

/// 보상형 광고 시청 후 골드 상태를 업데이트
void Function(void Function())? setStateGold;

/// 이미지 미리 로드하기
/// Board의 경우 이미지의 넓이와 높이를 알아야 해서 Board는 필수로 Preload
Future<void> imagePreload(BuildContext context) async {
  context.mounted ? await precacheImage(imageBoard, context) : null;

  context.mounted ? await precacheImage(imageRedKing, context) : null;
  context.mounted ? await precacheImage(imageRedSa, context) : null;
  context.mounted ? await precacheImage(imageRedCha, context) : null;
  context.mounted ? await precacheImage(imageRedPo, context) : null;
  context.mounted ? await precacheImage(imageRedMa, context) : null;
  context.mounted ? await precacheImage(imageRedSang, context) : null;
  context.mounted ? await precacheImage(imageRedByung, context) : null;

  context.mounted ? await precacheImage(imageBlueCha, context) : null;
  context.mounted ? await precacheImage(imageBluePo, context) : null;
  context.mounted ? await precacheImage(imageBlueMa, context) : null;
  context.mounted ? await precacheImage(imageBlueSang, context) : null;
  context.mounted ? await precacheImage(imageBlueZol, context) : null;
}
