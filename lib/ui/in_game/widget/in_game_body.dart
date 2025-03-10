import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/provider/in_game/in_game_navigator_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_piece_set_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_system_notification_provider.dart';
import 'package:samyeonchoga/ui/common/widget/image_assets.dart';
import 'package:samyeonchoga/ui/in_game/controller/board_position_value.dart';

class InGameBody extends ConsumerStatefulWidget {
  const InGameBody({super.key, required this.gameHadSaved});

  final bool gameHadSaved;

  @override
  ConsumerState<InGameBody> createState() => _InGameBodyState();
}

class _InGameBodyState extends ConsumerState<InGameBody> {
  /// GlobalKey를 생성하여 이미지 위젯의 상태를 추적
  final GlobalKey imageBoardKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      /// 이미지의 넓이 또는 높이를 이용하여 기물의 위치를 정의
      final renderBox =
          imageBoardKey.currentContext?.findRenderObject() as RenderBox;
      final size = renderBox.size;

      /// 장기판 사이즈에 따른 값 초기화
      initBoardPositionValue(
        context: context,
        boardWidth: size.width,
        boardHeight: size.height,
      );

      if (widget.gameHadSaved) {
        /// 기물 저장된 데이터로 초기화
        await ref
            .read(inGamePieceSetProvider.notifier)
            .initPieceWithSavedData();
      } else {
        /// 기물 초기화
        ref.read(inGamePieceSetProvider.notifier).initPieceSet();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pieceSet = ref.watch(inGamePieceSetProvider);
    final navigatorBoxList = ref.watch(inGameNavigatorProvider);
    final systemNotification = ref.watch(inGameSystemNotificationProvider);

    return ColoredBox(
      color: inGameBlackColor,
      child: Center(
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image(image: imageBoard, key: imageBoardKey),
            ),
            ...pieceSet,
            ...navigatorBoxList,
            ...systemNotification,
          ],
        ),
      ),
    );
  }
}
