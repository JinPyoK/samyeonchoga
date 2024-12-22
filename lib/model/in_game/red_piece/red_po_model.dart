import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/model/in_game/red_piece/find_red_actions.dart';
import 'package:samyeonchoga/provider/in_game/in_game_board_status.dart';
import 'package:samyeonchoga/ui/common/widget/image_assets.dart';

final class RedPoModel extends RedPieceBaseModel {
  RedPoModel({
    required super.x,
    required super.y,
  }) : super(
          team: Team.red,
          pieceType: PieceType.po,
          value: 70,
          imageProvider: imageRedPo,
        );

  @override
  void searchActionable() {
    /// 현재 액션 가능한 리스트를 비워준다.
    pieceActionable.clear();

    /// 포의 다리
    bool bridge = false;

    /// 기물이 갈 수 있는 길을 찾아서 리스트에 넣는다.
    /// for문 break를 원할 시 true 반환
    bool redPoStatusProcessing(int x, int y) {
      final status = inGameBoardStatus.getStatus(x, y);

      if (bridge) {
        if (status is PieceBaseModel) {
          if (status.team == Team.red) {
            return true;
          } else {
            if (status.pieceType == PieceType.po) {
              return true;
            } else {
              findRedActions(status, pieceActionable);
              return true;
            }
          }
        } else {
          findRedActions(status, pieceActionable);
          return false;
        }
      } else {
        if (status is PieceBaseModel) {
          if (status.pieceType == PieceType.po) {
            return true;
          } else {
            bridge = true;
            return false;
          }
        } else {
          return false;
        }
      }
    }

    bridge = false;

    /// 위
    for (int i = y - 1; i >= 0; i--) {
      final breakNow = redPoStatusProcessing(x, i);
      if (breakNow) break;
    }

    bridge = false;

    /// 아래
    for (int i = y + 1; i <= 9; i++) {
      final breakNow = redPoStatusProcessing(x, i);
      if (breakNow) break;
    }

    bridge = false;

    /// 왼쪽
    for (int i = x - 1; i >= 0; i--) {
      final breakNow = redPoStatusProcessing(i, y);
      if (breakNow) break;
    }

    bridge = false;

    /// 오른쪽
    for (int i = x + 1; i <= 8; i++) {
      final breakNow = redPoStatusProcessing(i, y);
      if (breakNow) break;
    }
    bridge = false;

    /// 포가 궁성 내부에 있을 때
    if (x == 3 && y == 7) {
      for (int i = x + 1, j = y + 1; i <= 5 && j <= 9; i++, j++) {
        final breakNow = redPoStatusProcessing(i, j);
        if (breakNow) break;
      }
    } else if (x == 5 && y == 7) {
      for (int i = x - 1, j = y + 1; i >= 3 && j <= 9; i--, j++) {
        final breakNow = redPoStatusProcessing(i, j);
        if (breakNow) break;
      }
    } else if (x == 3 && y == 9) {
      for (int i = x + 1, j = y - 1; i <= 5 && j >= 7; i++, j--) {
        final breakNow = redPoStatusProcessing(i, j);
        if (breakNow) break;
      }
    } else if (x == 5 && y == 9) {
      for (int i = x - 1, j = y - 1; i >= 3 && j >= 7; i--, j--) {
        final breakNow = redPoStatusProcessing(i, j);
        if (breakNow) break;
      }
    }
  }
}
