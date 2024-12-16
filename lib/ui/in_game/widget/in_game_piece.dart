import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samyeonchoga/model/in_game/piece_actionable_model.dart';
import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/provider/in_game/in_game_navigator_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_selected_piece_model.dart';
import 'package:samyeonchoga/ui/in_game/controller/board_position_value.dart';

class InGamePiece extends ConsumerStatefulWidget {
  const InGamePiece({super.key, required this.pieceModel});

  final PieceBaseModel pieceModel;

  @override
  ConsumerState<InGamePiece> createState() => _InGamePieceState();
}

class _InGamePieceState extends ConsumerState<InGamePiece> {
  double _spawnOpacity = 0;

  @override
  void initState() {
    super.initState();
    widget.pieceModel.setStateThisPiece = setState;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _spawnOpacity = 1;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      left: boardPositionXValue[widget.pieceModel.x],
      bottom: widget.pieceModel.pieceType == PieceType.king
          ? boardPositionYValueForKing[widget.pieceModel.y]
          : boardPositionYValue[widget.pieceModel.y],
      child: AnimatedOpacity(
        opacity: _spawnOpacity,
        duration: const Duration(seconds: 1),
        child: GestureDetector(
          onTap: () {
            if (widget.pieceModel.team == Team.red) {
              selectedPieceModel = widget.pieceModel;
              // ref.read(inGameNavigatorProvider.notifier).showPieceNavigator(
              //       widget.pieceModel.pieceActionable,
              //     );
              ref.read(inGameNavigatorProvider.notifier).showPieceNavigator(
                [
                  PieceActionableModel(targetX: 1, targetY: 2, targetValue: 30),
                  PieceActionableModel(targetX: 5, targetY: 7, targetValue: 30),
                  PieceActionableModel(targetX: 4, targetY: 6, targetValue: 30),
                ],
              );
            }
          },
          child: Image(
            image: widget.pieceModel.imageProvider,
            width: pieceSize,
          ),
        ),
      ),
    );
  }
}
