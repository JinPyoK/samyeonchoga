import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/provider/in_game/in_game_piece_set_provider.dart';
import 'package:samyeonchoga/ui/common/widget/image_assets.dart';
import 'package:samyeonchoga/ui/in_game/controller/board_position_value.dart';

class InGameBody extends ConsumerStatefulWidget {
  const InGameBody({super.key});

  @override
  ConsumerState<InGameBody> createState() => _InGameBodyState();
}

class _InGameBodyState extends ConsumerState<InGameBody> {
  /// GlobalKey를 생성하여 이미지 위젯의 상태를 추적
  final GlobalKey imageBoardKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// 이미지의 넓이 또는 높이를 이용하여 기물의 위치를 정의
      final renderBox =
          imageBoardKey.currentContext?.findRenderObject() as RenderBox;
      final size = renderBox.size;
      initBoardPositionValue(boardWidth: size.width, boardHeight: size.height);
      ref.read(inGamePieceSetProvider.notifier).initPieceSet();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pieceSet = ref.watch(inGamePieceSetProvider);

    return ColoredBox(
      color: inGameBlackColor,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            image: imageBoard,
            key: imageBoardKey,
          ),
          ...pieceSet,
        ],
      ),
    );
  }
}
