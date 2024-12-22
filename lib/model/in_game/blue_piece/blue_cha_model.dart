import 'package:samyeonchoga/model/in_game/blue_piece/find_blue_actions.dart';
import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/provider/in_game/in_game_board_status.dart';
import 'package:samyeonchoga/ui/common/widget/image_assets.dart';

final class BlueChaModel extends BluePieceBaseModel {
  BlueChaModel({
    required super.x,
    required super.y,
  }) : super(
          team: Team.blue,
          pieceType: PieceType.cha,
          value: 13,
          imageProvider: imageBlueCha,
        );

  @override
  void searchActionable() {
    /// 현재 액션 가능한 리스트를 비워준다.
    pieceActionable.clear();

    /// 기물이 갈 수 있는 길을 찾아서 리스트에 넣는다.
    /// for문 break를 원할 시 true 반환
    bool blueChaStatusProcessing(int x, int y) {
      final status = inGameBoardStatus.getStatus(x, y);
      if (status is PieceBaseModel) {
        if (status.team == Team.blue) {
          return true;
        } else {
          findBlueActions(status, pieceActionable);
          return true;
        }
      } else {
        findBlueActions(status, pieceActionable);
        return false;
      }
    }

    /// 위
    for (int i = y - 1; i >= 0; i--) {
      final breakNow = blueChaStatusProcessing(x, i);
      if (breakNow) break;
    }

    /// 아래
    for (int i = y + 1; i < 10; i++) {
      final breakNow = blueChaStatusProcessing(x, i);
      if (breakNow) break;
    }

    /// 왼쪽
    for (int i = x - 1; i >= 0; i--) {
      final breakNow = blueChaStatusProcessing(i, y);
      if (breakNow) break;
    }

    /// 오른쪽
    for (int i = x + 1; i < 9; i++) {
      final breakNow = blueChaStatusProcessing(i, y);
      if (breakNow) break;
    }

    /// 차가 궁성 내부에 있을 때
    if (x == 3 && y == 7) {
      for (int i = x + 1, j = y + 1; i <= 5 && j <= 9; i++, j++) {
        final breakNow = blueChaStatusProcessing(i, j);
        if (breakNow) break;
      }
    } else if (x == 5 && y == 7) {
      for (int i = x - 1, j = y + 1; i >= 3 && j <= 9; i--, j++) {
        final breakNow = blueChaStatusProcessing(i, j);
        if (breakNow) break;
      }
    } else if (x == 4 && y == 8) {
      findBlueActions(inGameBoardStatus.getStatus(3, 7), pieceActionable);
      findBlueActions(inGameBoardStatus.getStatus(5, 7), pieceActionable);
      findBlueActions(inGameBoardStatus.getStatus(3, 9), pieceActionable);
      findBlueActions(inGameBoardStatus.getStatus(5, 9), pieceActionable);
    } else if (x == 3 && y == 9) {
      for (int i = x + 1, j = y - 1; i <= 5 && j >= 7; i++, j--) {
        final breakNow = blueChaStatusProcessing(i, j);
        if (breakNow) break;
      }
    } else if (x == 5 && y == 9) {
      for (int i = x - 1, j = y - 1; i >= 3 && j >= 7; i--, j--) {
        final breakNow = blueChaStatusProcessing(i, j);
        if (breakNow) break;
      }
    }
  }
}
