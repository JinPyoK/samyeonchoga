import 'package:flutter/material.dart';
import 'package:samyeonchoga/ui/common/widget/image_assets.dart';

/// 이미지 미리 로드하기
/// Board의 경우 이미지의 넓이와 높이를 알아야 해서 Board는 필수로 Preload
Future<void> imagePreload(BuildContext context) async {
  await precacheImage(imageBoard, context);

  await precacheImage(imageRedKing, context);
  await precacheImage(imageRedSa, context);
  await precacheImage(imageRedCha, context);
  await precacheImage(imageRedPo, context);
  await precacheImage(imageRedMa, context);
  await precacheImage(imageRedSang, context);
  await precacheImage(imageRedByung, context);

  await precacheImage(imageBlueCha, context);
  await precacheImage(imageBluePo, context);
  await precacheImage(imageBlueMa, context);
  await precacheImage(imageBlueSang, context);
  await precacheImage(imageBlueZol, context);
}
