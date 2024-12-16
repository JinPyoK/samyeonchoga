import 'package:samyeonchoga/model/in_game/piece_actionable_model.dart';
import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/provider/in_game/in_game_board_status.dart';
import 'package:samyeonchoga/ui/common/widget/image_assets.dart';

final class RedChaModel extends RedPieceBaseModel {
  RedChaModel({
    required super.x,
    required super.y,
  }) : super(
          team: Team.red,
          pieceType: PieceType.cha,
          value: 130,
          imageProvider: imageRedCha,
        );

  @override
  void searchActionable() {
    /// 현재 액션 가능한 리스트를 비워준다.
    pieceActionable.clear();

    /// 기물이 갈 수 있는 길을 찾아서 리스트에 넣는다.
    void findRedChaActions(PieceOrJustActionable status) {
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

    /// 위
    for (int i = y - 1; i >= 0; i--) {
      final status = getStatus(x, i);
      if (status is PieceBaseModel) {
        if (status.team == Team.red) {
          break;
        } else if (status.team == Team.blue) {
          findRedChaActions(status);
          break;
        }
      } else {
        findRedChaActions(status);
      }
    }

    /// 아래
    for (int i = y + 1; i < 10; i++) {
      final status = getStatus(x, i);
      if (status is PieceBaseModel) {
        if (status.team == Team.red) {
          break;
        } else if (status.team == Team.blue) {
          findRedChaActions(status);
          break;
        }
      } else {
        findRedChaActions(status);
      }
    }

    /// 왼쪽
    for (int i = x - 1; i >= 0; i--) {
      final status = getStatus(i, y);
      if (status is PieceBaseModel) {
        if (status.team == Team.red) {
          break;
        } else if (status.team == Team.blue) {
          findRedChaActions(status);
          break;
        }
      } else {
        findRedChaActions(status);
      }
    }

    /// 오른쪽
    for (int i = x + 1; i < 9; i++) {
      final status = getStatus(i, y);
      if (status is PieceBaseModel) {
        if (status.team == Team.red) {
          break;
        } else if (status.team == Team.blue) {
          findRedChaActions(status);
          break;
        }
      } else {
        findRedChaActions(status);
      }
    }

    /// 차가 궁성 내부에 있을 때
    if (x == 3 && y == 7) {
      for (int i = x + 1, j = y + 1; i <= 5 && j <= 9; i++, j++) {
        final status = getStatus(i, j);

        if (status is PieceBaseModel) {
          if (status.team == Team.red) {
            break;
          } else if (status.team == Team.blue) {
            findRedChaActions(status);
            break;
          }
        } else {
          findRedChaActions(status);
        }
      }
    } else if (x == 5 && y == 7) {
      for (int i = x - 1, j = y + 1; i >= 3 && j <= 9; i--, j++) {
        final status = getStatus(i, j);

        if (status is PieceBaseModel) {
          if (status.team == Team.red) {
            break;
          } else if (status.team == Team.blue) {
            findRedChaActions(status);
            break;
          }
        } else {
          findRedChaActions(status);
        }
      }
    } else if (x == 4 && y == 8) {
      findRedChaActions(getStatus(3, 7));
      findRedChaActions(getStatus(5, 7));
      findRedChaActions(getStatus(3, 9));
      findRedChaActions(getStatus(5, 9));
    } else if (x == 3 && y == 9) {
      for (int i = x + 1, j = y - 1; i <= 5 && j >= 7; i++, j--) {
        final status = getStatus(i, j);

        if (status is PieceBaseModel) {
          if (status.team == Team.red) {
            break;
          } else if (status.team == Team.blue) {
            findRedChaActions(status);
            break;
          }
        } else {
          findRedChaActions(status);
        }
      }
    } else if (x == 5 && y == 9) {
      for (int i = x - 1, j = y - 1; i >= 3 && j >= 7; i--, j--) {
        final status = getStatus(i, j);

        if (status is PieceBaseModel) {
          if (status.team == Team.red) {
            break;
          } else if (status.team == Team.blue) {
            findRedChaActions(status);
            break;
          }
        } else {
          findRedChaActions(status);
        }
      }
    }
  }
}
