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

    /// 기물이 갈 수 있는 길을 찾아서 리스트에 넣는다.
    /// for문 break를 원할 시 true 반환
    bool redPoStatusProcessing(int x, int y) {
      final status = getStatus(x, y);
      if (status is PieceBaseModel) {
        if (status.team == Team.red) {
          return true;
        } else if (status.team == Team.blue) {
          findRedActions(status, pieceActionable);
          return true;
        }
      } else {
        findRedActions(status, pieceActionable);
        return false;
      }
      return false;
    }

    /// 위
    for (int i = y - 1; i >= 0; i--) {
      bool bridge = false;
    }

    /// 아래
    for (int i = y + 1; i <= 9; i++) {
      bool bridge = false;
    }

    /// 왼쪽
    for (int i = x - 1; i >= 0; i--) {
      bool bridge = false;
    }

    /// 오른쪽
    for (int i = x + 1; i <= 8; i++) {
      bool bridge = false;
    }
  }
}
