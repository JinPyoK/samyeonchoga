import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/find_blue_actions.dart';
import 'package:samyeonchoga/provider/in_game/in_game_board_status.dart';
import 'package:samyeonchoga/ui/common/widget/image_assets.dart';

final class BlueZolModel extends BluePieceBaseModel {
  BlueZolModel({
    required super.x,
    required super.y,
  }) : super(
          team: Team.blue,
          pieceType: PieceType.zol,
          value: 20,
          imageProvider: imageBlueZol,
        );

  @override
  void searchActionable(InGameBoardStatus statusBoard) {
    /// 현재 액션 가능한 리스트를 비워준다.
    pieceActionable.clear();

    /// 기물이 갈 수 있는 길을 찾아서 리스트에 넣는다.

    /// 왼쪽
    if (x > 0) {
      final status = statusBoard.getStatus(x - 1, y);
      findBlueActions(status, pieceActionable);
    }

    /// 위
    if (y > 0) {
      final status = statusBoard.getStatus(x, y - 1);
      findBlueActions(status, pieceActionable);
    }

    /// 오른쪽
    if (x < 8) {
      final status = statusBoard.getStatus(x + 1, y);
      findBlueActions(status, pieceActionable);
    }

    /// 병이 궁성 내부에 있을 때
    if (x == 3 && y == 9) {
      final status = statusBoard.getStatus(x + 1, y - 1);
      findBlueActions(status, pieceActionable);
    }

    if (x == 5 && y == 9) {
      final status = statusBoard.getStatus(x - 1, y - 1);
      findBlueActions(status, pieceActionable);
    }

    if (x == 4 && y == 8) {
      final status1 = statusBoard.getStatus(x - 1, y - 1);
      final status2 = statusBoard.getStatus(x + 1, y - 1);

      findBlueActions(status1, pieceActionable);
      findBlueActions(status2, pieceActionable);
    }
  }
}
