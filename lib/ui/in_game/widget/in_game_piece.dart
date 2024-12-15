import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
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
      left: boardPositionXValue[widget.pieceModel.x],
      bottom: widget.pieceModel.pieceType == PieceType.king
          ? boardPositionYValueForKing[widget.pieceModel.y]
          : boardPositionYValue[widget.pieceModel.y],
      child: AnimatedOpacity(
        opacity: _spawnOpacity,
        duration: const Duration(seconds: 1),
        child: GestureDetector(
          onTap: () {
            log("네비게이터 생성");
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
