import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/provider/in_game/in_game_board_status.dart';
import 'package:samyeonchoga/provider/in_game/in_game_navigator_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_red_status.dart';
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
  double _spawnScale = 1;

  bool _callJanggoon = false;

  void _onPieceTaped() {
    final isMyTurn = ref.read(inGameTurnProvider);

    if (widget.pieceModel.team == Team.blue && isMyTurn) {
      selectedPieceModel = widget.pieceModel;
      widget.pieceModel.searchActionable(inGameBoardStatus);
      ref
          .read(inGameNavigatorProvider.notifier)
          .showPieceNavigator(widget.pieceModel.pieceActionable);

      makePieceTapSound();
    }
  }

  List<Color> _justTurnPieceColor() {
    /// 한나라 기물의 수가 60 이상
    final onTheRopes = ref.watch(inGameOnTheRopesProvider);

    if (widget.pieceModel.team == Team.red) {
      if (onTheRopes) {
        return [
          whiteColor,
          redColor,
        ];
      } else {
        if (widget.pieceModel.justTurn) {
          return [
            whiteColor,
            redColor,
          ];
        } else {
          return [
            whiteColor,
            whiteColor,
          ];
        }
      }
    } else {
      if (widget.pieceModel.justTurn) {
        return [
          whiteColor,
          Colors.blueAccent,
        ];
      } else {
        return [
          whiteColor,
          whiteColor,
        ];
      }
    }
  }

  @override
  void initState() {
    super.initState();

    widget.pieceModel.setStateThisPiece = setState;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _spawnOpacity = 1;
      _spawnScale = 1.5;
      setState(() {});

      Future.delayed(const Duration(milliseconds: 500), () {
        _spawnScale = 1;
        setState(() {});
      });
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (widget.pieceModel is RedPieceBaseModel) {
      final redPieceModel = widget.pieceModel as RedPieceBaseModel;

      _callJanggoon = redPieceModel.isTargetingKing;
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
          AnimatedScale(
            scale: _spawnScale,
            duration: const Duration(milliseconds: 500),
            curve: Curves.bounceInOut,
            child: AnimatedOpacity(
              opacity: _spawnOpacity,
              duration: const Duration(seconds: 2),
              curve: Curves.easeOut,
              child: GestureDetector(
                onTap: _onPieceTaped,
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return RadialGradient(colors: _justTurnPieceColor())
                        .createShader(rect);
                  },
                  child: Image(
                    image: widget.pieceModel.imageProvider,
                    width: pieceSize,
                  ),
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
