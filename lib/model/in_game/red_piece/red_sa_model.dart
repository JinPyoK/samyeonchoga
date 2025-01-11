import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/model/in_game/red_piece/find_red_actions.dart';
import 'package:samyeonchoga/provider/in_game/in_game_board_status.dart';
import 'package:samyeonchoga/ui/common/widget/image_assets.dart';

final class RedSaModel extends RedPieceBaseModel {
  RedSaModel({
    required super.x,
    required super.y,
  }) : super(
          team: Team.red,
          pieceType: PieceType.sa,
          value: 30,
          imageProvider: imageBlueSa,
        );

  @override
  void searchActionable(InGameBoardStatus statusBoard) {
    /// 현재 액션 가능한 리스트를 비워준다.
    pieceActionable.clear();

    /// 기물이 갈 수 있는 길을 찾아서 리스트에 넣는다.

    /// 사 액션 탐색
    void findSaActions(List<PieceOrJustActionable> statusList) {
      for (PieceOrJustActionable status in statusList) {
        findRedActions(status, pieceActionable);
      }
    }

    if (x == 3 && y == 9) {
      final statusList = <PieceOrJustActionable>[
        statusBoard.getStatus(3, 8),
        statusBoard.getStatus(4, 9),
        statusBoard.getStatus(4, 8),
      ];

      findSaActions(statusList);
    } else if (x == 4 && y == 9) {
      final statusList = <PieceOrJustActionable>[
        statusBoard.getStatus(3, 9),
        statusBoard.getStatus(4, 8),
        statusBoard.getStatus(5, 9),
      ];

      findSaActions(statusList);
    } else if (x == 5 && y == 9) {
      final statusList = <PieceOrJustActionable>[
        statusBoard.getStatus(4, 9),
        statusBoard.getStatus(4, 8),
        statusBoard.getStatus(5, 8),
      ];

      findSaActions(statusList);
    } else if (x == 3 && y == 8) {
      final statusList = <PieceOrJustActionable>[
        statusBoard.getStatus(3, 7),
        statusBoard.getStatus(4, 8),
        statusBoard.getStatus(3, 9),
      ];

      findSaActions(statusList);
    } else if (x == 4 && y == 8) {
      final statusList = <PieceOrJustActionable>[
        statusBoard.getStatus(3, 7),
        statusBoard.getStatus(4, 7),
        statusBoard.getStatus(5, 7),
        statusBoard.getStatus(3, 8),
        statusBoard.getStatus(5, 8),
        statusBoard.getStatus(3, 9),
        statusBoard.getStatus(4, 9),
        statusBoard.getStatus(5, 9),
      ];

      findSaActions(statusList);
    } else if (x == 5 && y == 8) {
      final statusList = <PieceOrJustActionable>[
        statusBoard.getStatus(5, 7),
        statusBoard.getStatus(4, 8),
        statusBoard.getStatus(5, 9),
      ];

      findSaActions(statusList);
    } else if (x == 3 && y == 7) {
      final statusList = <PieceOrJustActionable>[
        statusBoard.getStatus(4, 7),
        statusBoard.getStatus(4, 8),
        statusBoard.getStatus(3, 8),
      ];

      findSaActions(statusList);
    } else if (x == 4 && y == 7) {
      final statusList = <PieceOrJustActionable>[
        statusBoard.getStatus(3, 7),
        statusBoard.getStatus(4, 8),
        statusBoard.getStatus(5, 7),
      ];

      findSaActions(statusList);
    } else if (x == 5 && y == 7) {
      final statusList = <PieceOrJustActionable>[
        statusBoard.getStatus(4, 7),
        statusBoard.getStatus(4, 8),
        statusBoard.getStatus(5, 8),
      ];

      findSaActions(statusList);
    }
  }
}
