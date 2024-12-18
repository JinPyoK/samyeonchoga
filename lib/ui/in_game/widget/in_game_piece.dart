import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/provider/in_game/in_game_navigator_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_round_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_selected_piece_model.dart';
import 'package:samyeonchoga/provider/in_game/in_game_turn_provider.dart';
import 'package:samyeonchoga/ui/in_game/controller/board_position_value.dart';

class InGamePiece extends ConsumerStatefulWidget {
  const InGamePiece({super.key, required this.pieceModel});

  final PieceBaseModel pieceModel;

  @override
  ConsumerState<InGamePiece> createState() => _InGamePieceState();
}

class _InGamePieceState extends ConsumerState<InGamePiece> {
  double _spawnOpacity = 0;
  double _pieceScale = 1;

  void _onPieceTaped() {
    final isMyTurn = ref.read(inGameTurnProvider);
    final justGameStart = ref.read(inGameRoundProvider) == 0;
    if (widget.pieceModel.team == Team.red && isMyTurn && !justGameStart) {
      selectedPieceModel = widget.pieceModel;
      widget.pieceModel.searchActionable();
      ref
          .read(inGameNavigatorProvider.notifier)
          .showPieceNavigator(widget.pieceModel.pieceActionable);
    }
  }

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
  void setState(VoidCallback fn) {
    /// 뛰는 기물이면 스케일 애니메이션 동작
    if (widget.pieceModel.pieceType == PieceType.po ||
        widget.pieceModel.pieceType == PieceType.ma ||
        widget.pieceModel.pieceType == PieceType.sang) {
      _pieceScale = 1.3;
      super.setState(fn);

      Future.delayed(const Duration(milliseconds: 200), () {
        _pieceScale = 1;
        super.setState(fn);
      });
    }
    super.setState(fn);
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
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        scale: _pieceScale,
        child: AnimatedOpacity(
          opacity: _spawnOpacity,
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
          child: GestureDetector(
            onTap: _onPieceTaped,
            child: Image(
              image: widget.pieceModel.imageProvider,
              width: pieceSize,
            ),
          ),
        ),
      ),
    );
  }
}
