import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/model/in_game/red_piece/find_red_actions.dart';
import 'package:samyeonchoga/provider/in_game/in_game_board_status.dart';
import 'package:samyeonchoga/ui/common/widget/image_assets.dart';

final class RedKingModel extends RedPieceBaseModel {
  RedKingModel({
    required super.x,
    required super.y,
  }) : super(
          team: Team.red,
          pieceType: PieceType.king,
          value: 1000,
          imageProvider: imageRedKing,
        );

  @override
  void searchActionable() {
    /// 현재 액션 가능한 리스트를 비워준다.
    pieceActionable.clear();

    /// 기물이 갈 수 있는 길을 찾아서 리스트에 넣는다.

    /// 왕 액션 탐색
    void findKingActions(List<PieceOrJustActionable> statusList) {
      for (PieceOrJustActionable status in statusList) {
        findRedActions(status, pieceActionable);
      }
    }

    if (x == 3 && y == 9) {
      final statusList = <PieceOrJustActionable>[
        getStatus(3, 8),
        getStatus(4, 9),
        getStatus(4, 8),
      ];

      findKingActions(statusList);
    } else if (x == 4 && y == 9) {
      final statusList = <PieceOrJustActionable>[
        getStatus(3, 9),
        getStatus(4, 8),
        getStatus(5, 9),
      ];

      findKingActions(statusList);
    } else if (x == 5 && y == 9) {
      final statusList = <PieceOrJustActionable>[
        getStatus(4, 9),
        getStatus(4, 8),
        getStatus(5, 8),
      ];

      findKingActions(statusList);
    } else if (x == 3 && y == 8) {
      final statusList = <PieceOrJustActionable>[
        getStatus(3, 7),
        getStatus(4, 8),
        getStatus(3, 9),
      ];

      findKingActions(statusList);
    } else if (x == 4 && y == 8) {
      final statusList = <PieceOrJustActionable>[
        getStatus(3, 7),
        getStatus(4, 7),
        getStatus(5, 7),
        getStatus(3, 8),
        getStatus(5, 8),
        getStatus(3, 9),
        getStatus(4, 9),
        getStatus(5, 9),
      ];

      findKingActions(statusList);
    } else if (x == 5 && y == 8) {
      final statusList = <PieceOrJustActionable>[
        getStatus(5, 7),
        getStatus(4, 8),
        getStatus(5, 9),
      ];

      findKingActions(statusList);
    } else if (x == 3 && y == 7) {
      final statusList = <PieceOrJustActionable>[
        getStatus(4, 7),
        getStatus(4, 8),
        getStatus(3, 8),
      ];

      findKingActions(statusList);
    } else if (x == 4 && y == 7) {
      final statusList = <PieceOrJustActionable>[
        getStatus(3, 7),
        getStatus(4, 8),
        getStatus(5, 7),
      ];

      findKingActions(statusList);
    } else if (x == 5 && y == 7) {
      final statusList = <PieceOrJustActionable>[
        getStatus(4, 7),
        getStatus(4, 8),
        getStatus(5, 8),
      ];

      findKingActions(statusList);
    }
  }
}
