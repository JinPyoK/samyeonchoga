import 'package:samyeonchoga/model/in_game/piece_actionable_model.dart';
import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
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
          imageProvider: imageRedSa,
        );

  @override
  void searchActionable() {
    /// 현재 액션 가능한 리스트를 비워준다.
    pieceActionable.clear();

    /// 기물이 갈 수 있는 길을 찾아서 리스트에 넣는다.

    /// 사 액션 탐색
    void findSaActions(List<PieceOrJustActionable> statusList) {
      for (PieceOrJustActionable status in statusList) {
        if (status is PieceActionableModel) {
          pieceActionable.add(
            PieceActionableModel(
              targetX: status.targetX,
              targetY: status.targetY,
              targetValue: 0,
            ),
          );
        } else if (status is PieceBaseModel) {
          if (status.team == Team.blue) {
            pieceActionable.add(
              PieceActionableModel(
                targetX: status.x,
                targetY: status.y,
                targetValue: status.value,
              ),
            );
          }
        }
      }
    }

    if (x == 3 && y == 9) {
      final statusList = <PieceOrJustActionable>[
        getStatus(3, 8),
        getStatus(4, 9),
        getStatus(4, 8),
      ];

      findSaActions(statusList);
    } else if (x == 4 && y == 9) {
      final statusList = <PieceOrJustActionable>[
        getStatus(3, 9),
        getStatus(4, 8),
        getStatus(5, 9),
      ];

      findSaActions(statusList);
    } else if (x == 5 && y == 9) {
      final statusList = <PieceOrJustActionable>[
        getStatus(4, 9),
        getStatus(4, 8),
        getStatus(5, 8),
      ];

      findSaActions(statusList);
    } else if (x == 3 && y == 8) {
      final statusList = <PieceOrJustActionable>[
        getStatus(3, 7),
        getStatus(4, 8),
        getStatus(3, 9),
      ];

      findSaActions(statusList);
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

      findSaActions(statusList);
    } else if (x == 5 && y == 8) {
      final statusList = <PieceOrJustActionable>[
        getStatus(5, 7),
        getStatus(4, 8),
        getStatus(5, 9),
      ];

      findSaActions(statusList);
    } else if (x == 3 && y == 7) {
      final statusList = <PieceOrJustActionable>[
        getStatus(4, 7),
        getStatus(4, 8),
        getStatus(3, 8),
      ];

      findSaActions(statusList);
    } else if (x == 4 && y == 7) {
      final statusList = <PieceOrJustActionable>[
        getStatus(3, 7),
        getStatus(4, 8),
        getStatus(5, 7),
      ];

      findSaActions(statusList);
    } else if (x == 5 && y == 7) {
      final statusList = <PieceOrJustActionable>[
        getStatus(4, 7),
        getStatus(4, 8),
        getStatus(5, 8),
      ];

      findSaActions(statusList);
    }
  }
}
