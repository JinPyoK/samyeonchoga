import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/find_blue_actions.dart';
import 'package:samyeonchoga/provider/in_game/in_game_board_status.dart';
import 'package:samyeonchoga/ui/common/widget/image_assets.dart';

final class BlueSangModel extends BluePieceBaseModel {
  BlueSangModel({required super.x, required super.y})
    : super(
        team: Team.blue,
        pieceType: PieceType.sang,
        value: 30,
        imageProvider: imageBlueSang,
      );

  @override
  void searchActionable(InGameBoardStatus statusBoard) {
    /// 현재 액션 가능한 리스트를 비워준다.
    pieceActionable.clear();

    /// 기물이 갈 수 있는 길을 찾아서 리스트에 넣는다.
    /// 0: 아무것도 없음, 1: 초나라의 기물이 있음, 2: 한나라의 기물이 있음
    List<dynamic> blueSangStatusProcessing(int x, int y) {
      final status = statusBoard.getStatus(x, y);
      if (status is PieceBaseModel) {
        if (status.team == Team.blue) {
          return [1, status];
        } else {
          return [2, status];
        }
      } else {
        return [0, status];
      }
    }

    /// 위
    if (y >= 3) {
      final proc = blueSangStatusProcessing(x, y - 1);

      if (proc[0] == 0) {
        /// 왼쪽
        if (x > 1) {
          final proc = blueSangStatusProcessing(x - 1, y - 2);

          if (proc[0] == 0) {
            final proc = blueSangStatusProcessing(x - 2, y - 3);

            if (proc[0] != 1) {
              findBlueActions(proc[1], pieceActionable);
            }
          }
        }

        /// 오른쪽
        if (x < 7) {
          final proc = blueSangStatusProcessing(x + 1, y - 2);

          if (proc[0] == 0) {
            final proc = blueSangStatusProcessing(x + 2, y - 3);

            if (proc[0] != 1) {
              findBlueActions(proc[1], pieceActionable);
            }
          }
        }
      }
    }

    /// 아래
    if (y <= 6) {
      final proc = blueSangStatusProcessing(x, y + 1);

      if (proc[0] == 0) {
        /// 왼쪽
        if (x > 1) {
          final proc = blueSangStatusProcessing(x - 1, y + 2);

          if (proc[0] == 0) {
            final proc = blueSangStatusProcessing(x - 2, y + 3);

            if (proc[0] != 1) {
              findBlueActions(proc[1], pieceActionable);
            }
          }
        }

        /// 오른쪽
        if (x < 7) {
          final proc = blueSangStatusProcessing(x + 1, y + 2);

          if (proc[0] == 0) {
            final proc = blueSangStatusProcessing(x + 2, y + 3);

            if (proc[0] != 1) {
              findBlueActions(proc[1], pieceActionable);
            }
          }
        }
      }
    }

    /// 왼쪽
    if (x >= 3) {
      final proc = blueSangStatusProcessing(x - 1, y);

      if (proc[0] == 0) {
        /// 위
        if (y > 1) {
          final proc = blueSangStatusProcessing(x - 2, y - 1);

          if (proc[0] == 0) {
            final proc = blueSangStatusProcessing(x - 3, y - 2);

            if (proc[0] != 1) {
              findBlueActions(proc[1], pieceActionable);
            }
          }
        }

        /// 아래
        if (y < 8) {
          final proc = blueSangStatusProcessing(x - 2, y + 1);

          if (proc[0] == 0) {
            final proc = blueSangStatusProcessing(x - 3, y + 2);

            if (proc[0] != 1) {
              findBlueActions(proc[1], pieceActionable);
            }
          }
        }
      }
    }

    /// 오른쪽
    if (x <= 5) {
      final proc = blueSangStatusProcessing(x + 1, y);

      if (proc[0] == 0) {
        /// 위
        if (y > 1) {
          final proc = blueSangStatusProcessing(x + 2, y - 1);

          if (proc[0] == 0) {
            final proc = blueSangStatusProcessing(x + 3, y - 2);

            if (proc[0] != 1) {
              findBlueActions(proc[1], pieceActionable);
            }
          }
        }

        /// 아래
        if (y < 8) {
          final proc = blueSangStatusProcessing(x + 2, y + 1);

          if (proc[0] == 0) {
            final proc = blueSangStatusProcessing(x + 3, y + 2);

            if (proc[0] != 1) {
              findBlueActions(proc[1], pieceActionable);
            }
          }
        }
      }
    }
  }
}
