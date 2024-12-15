import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/model/in_game/navigator_type_enum.dart';
import 'package:samyeonchoga/model/in_game/piece_actionable_model.dart';
import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_byung_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_cha_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_ma_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_po_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_sa_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_sang_model.dart';
import 'package:samyeonchoga/provider/in_game/in_game_board_status.dart';
import 'package:samyeonchoga/provider/in_game/in_game_footer_spawn_piece_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_navigator_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_piece_set_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_selected_piece_model.dart';
import 'package:samyeonchoga/ui/in_game/controller/board_position_value.dart';

class InGameNavigatorBox extends ConsumerStatefulWidget {
  const InGameNavigatorBox({
    super.key,
    required this.pieceActionable,
    this.navigatorType = NavigatorType.pieceMove,
  });

  final PieceActionableModel pieceActionable;
  final NavigatorType navigatorType;

  @override
  ConsumerState<InGameNavigatorBox> createState() => _InGameNavigatorState();
}

class _InGameNavigatorState extends ConsumerState<InGameNavigatorBox> {
  double _navigatorOpacity = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigatorOpacity = 1;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left:
          boardPositionXValue[widget.pieceActionable.targetX]! + pieceSize / 5,
      bottom:
          boardPositionYValue[widget.pieceActionable.targetY]! + pieceSize / 5,
      child: AnimatedOpacity(
        opacity: _navigatorOpacity,
        duration: const Duration(milliseconds: 500),
        child: GestureDetector(
          onTap: () {
            if (widget.navigatorType == NavigatorType.pieceMove) {
              /// 네비게이터 삭제
              ref.read(inGameNavigatorProvider.notifier).clearNavigator();

              /// 보드 상태 변경
              changeStatus(selectedPieceModel!.x, selectedPieceModel!.y, null);
              changeStatus(widget.pieceActionable.targetX,
                  widget.pieceActionable.targetY, selectedPieceModel!);

              /// 기물 착수
              selectedPieceModel!.x = widget.pieceActionable.targetX;
              selectedPieceModel!.y = widget.pieceActionable.targetY;
              selectedPieceModel!.setStateThisPiece!(() {});
            } else if (widget.navigatorType == NavigatorType.spawn) {
              ref.read(inGameNavigatorProvider.notifier).clearNavigator();
              late PieceBaseModel spawnPieceModel;
              final pieceType = ref.read(inGameFooterSpawnPieceProvider);
              if (pieceType == PieceType.cha) {
                spawnPieceModel = RedChaModel(
                  x: widget.pieceActionable.targetX,
                  y: widget.pieceActionable.targetY,
                );
              } else if (pieceType == PieceType.po) {
                spawnPieceModel = RedPoModel(
                  x: widget.pieceActionable.targetX,
                  y: widget.pieceActionable.targetY,
                );
              } else if (pieceType == PieceType.ma) {
                spawnPieceModel = RedMaModel(
                  x: widget.pieceActionable.targetX,
                  y: widget.pieceActionable.targetY,
                );
              } else if (pieceType == PieceType.sang) {
                spawnPieceModel = RedSangModel(
                  x: widget.pieceActionable.targetX,
                  y: widget.pieceActionable.targetY,
                );
              } else if (pieceType == PieceType.sa) {
                spawnPieceModel = RedSaModel(
                  x: widget.pieceActionable.targetX,
                  y: widget.pieceActionable.targetY,
                );
              } else {
                spawnPieceModel = RedByungModel(
                  x: widget.pieceActionable.targetX,
                  y: widget.pieceActionable.targetY,
                );
              }

              ref
                  .read(inGamePieceSetProvider.notifier)
                  .spawnPiece(spawnPieceModel);
            } else if (widget.navigatorType == NavigatorType.execute) {
              ref.read(inGameNavigatorProvider.notifier).clearNavigator();
              ref
                  .read(inGamePieceSetProvider.notifier)
                  .removePiece(widget.pieceActionable, true);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: widget.navigatorType == NavigatorType.spawn
                    ? Colors.lightGreenAccent
                    : redColor,
              ),
              borderRadius: BorderRadius.circular(8),
              color: Colors.transparent,
            ),
            width: pieceSize / 1.7,
            height: pieceSize / 1.7,
          ),
        ),
      ),
    );
  }
}