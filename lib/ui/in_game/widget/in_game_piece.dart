import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samyeonchoga/model/in_game/piece_base_model.dart';

class InGamePiece extends ConsumerStatefulWidget {
  const InGamePiece({super.key, required this.pieceModel});

  final PieceBaseModel pieceModel;

  @override
  ConsumerState<InGamePiece> createState() => _InGamePieceState();
}

class _InGamePieceState extends ConsumerState<InGamePiece> {
  @override
  void initState() {
    super.initState();
    widget.pieceModel.setStateThisPiece = setState;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
