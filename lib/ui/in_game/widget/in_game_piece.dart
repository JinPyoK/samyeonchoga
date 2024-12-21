import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/provider/in_game/in_game_navigator_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_round_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_selected_piece_model.dart';
import 'package:samyeonchoga/provider/in_game/in_game_turn_provider.dart';
import 'package:samyeonchoga/ui/audio/controller/sound_play.dart';
import 'package:samyeonchoga/ui/in_game/controller/board_position_value.dart';
import 'package:samyeonchoga/ui/in_game/widget/system_notification/piece_janggoon_notification.dart';

class InGamePiece extends ConsumerStatefulWidget {
  const InGamePiece({super.key, required this.pieceModel});

  final PieceBaseModel pieceModel;

  @override
  ConsumerState<InGamePiece> createState() => _InGamePieceState();
}

class _InGamePieceState extends ConsumerState<InGamePiece> {
  double _spawnOpacity = 0;

  bool _callJanggoon = false;

  void _onPieceTaped() {
    final isMyTurn = ref.read(inGameTurnProvider);
    final justGameStart = ref.read(inGameRoundProvider) == 0;
    if (widget.pieceModel.team == Team.red && isMyTurn && !justGameStart) {
      selectedPieceModel = widget.pieceModel;
      widget.pieceModel.searchActionable();
      ref
          .read(inGameNavigatorProvider.notifier)
          .showPieceNavigator(widget.pieceModel.pieceActionable);

      makePieceTapSound();
    }
  }

  List<Color> justTurnPieceColor() {
    if (widget.pieceModel.justTurn) {
      if (widget.pieceModel.team == Team.red) {
        return [
          whiteColor,
          redColor,
        ];
      } else {
        return [
          whiteColor,
          Colors.blueAccent,
        ];
      }
    } else {
      return [
        whiteColor,
        whiteColor,
      ];
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
    if (widget.pieceModel is BluePieceBaseModel) {
      final bluePieceModel = widget.pieceModel as BluePieceBaseModel;

      _callJanggoon = bluePieceModel.isTargetingKing;
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
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          AnimatedOpacity(
            opacity: _spawnOpacity,
            duration: const Duration(seconds: 3),
            curve: Curves.easeOut,
            child: GestureDetector(
              onTap: _onPieceTaped,
              child: ShaderMask(
                shaderCallback: (rect) {
                  return RadialGradient(colors: justTurnPieceColor())
                      .createShader(rect);
                },
                child: Image(
                  image: widget.pieceModel.imageProvider,
                  width: pieceSize,
                ),
              ),
            ),
          ),
          if (_callJanggoon)
            Transform.translate(
              offset: Offset(0, -pieceSize / 2),
              child: const PieceJanggoonNotification(),
            ),
        ],
      ),
    );
  }
}
