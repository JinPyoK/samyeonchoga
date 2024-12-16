import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samyeonchoga/model/in_game/piece_actionable_model.dart';
import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/provider/in_game/in_game_board_status.dart';
import 'package:samyeonchoga/provider/in_game/in_game_piece_set_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_round_provider.dart';

part 'in_game_turn_provider.g.dart';

@Riverpod()
final class InGameTurn extends _$InGameTurn {
  @override
  bool build() {
    return true;
  }

  void changeTurn() {
    state = !state;

    /// 초나라의 턴이라면 라운드를 증가시키고 초나라 착수
    if (state == false) {
      ref.read(inGameRoundProvider.notifier).nextRound();
      _blueAction();
    }
  }

  void _blueAction() {
    final minimaxResult = _minimax();

    if (minimaxResult.isEmpty) {
      return;
    }

    final piece = minimaxResult[0] as PieceBaseModel;
    final pieceActionable = minimaxResult[1] as PieceActionableModel;

    /// 보드 상태 변경
    changeStatus(
      piece.x,
      piece.y,
      PieceActionableModel(
        targetX: piece.x,
        targetY: piece.y,
        targetValue: 0,
      ),
    );

    /// 움직인 자리에 한나라 기물이 있다면 제거하기
    final status = getStatus(pieceActionable.targetX, pieceActionable.targetY);
    if (status is PieceBaseModel) {
      if (status.team == Team.red) {
        ref.read(inGamePieceSetProvider.notifier).removePiece(pieceActionable);
      }
    }

    changeStatus(pieceActionable.targetX, pieceActionable.targetY, piece);

    /// 기물 착수
    piece.x = pieceActionable.targetX;
    piece.y = pieceActionable.targetY;
    piece.setStateThisPiece!(() {});
    ref.read(inGameTurnProvider.notifier).changeTurn();
  }

  /// 미니맥스 알고리즘으로 교체해야 하나, 지금은 랜덤으로 하기
  List<dynamic> _minimax() {
    final blueList = getBlueAll();

    for (PieceBaseModel piece in blueList) {
      piece.searchActionable();
      if (piece.pieceActionable.isNotEmpty) {
        return [piece, piece.pieceActionable[0]];
      }
    }

    return [];
  }
}
