import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samyeonchoga/core/constant/asset_path.dart';
import 'package:samyeonchoga/core/constant/color.dart';

class InGameBody extends ConsumerStatefulWidget {
  const InGameBody({super.key});

  @override
  ConsumerState<InGameBody> createState() => _InGameBodyState();
}

class _InGameBodyState extends ConsumerState<InGameBody> {
  /// GlobalKey를 생성하여 이미지 위젯의 상태를 추적
  final GlobalKey imageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// 이미지의 넓이 또는 높이를 이용하여 기물의 위치를 정의
      final renderBox =
          imageKey.currentContext?.findRenderObject() as RenderBox;
      final size = renderBox.size;

      log('이미지 넓이: ${size.width}, 높이: ${size.height}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: inGameBlackColor,
      child: Image.asset(
        key: imageKey,
        imageBoardPath,
      ),
    );
  }
}
