import 'package:samyeonchoga/model/in_game/piece_actionable_model.dart';
import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';

List<List<PieceOrJustActionable>> _inGameBoardStatus = List.generate(
    9,
    (x) => List<PieceOrJustActionable>.generate(10,
        (y) => PieceActionableModel(targetX: x, targetY: y, targetValue: 0)));

PieceOrJustActionable getStatus(int x, int y) => _inGameBoardStatus[x][y];

void changeStatus(int x, int y, PieceOrJustActionable pieceModel) =>
    _inGameBoardStatus[x][y] = pieceModel;

/// 초나라의 행마 조사를 하기 위함
List<PieceBaseModel> getBlueAll() {
  final blueList = <PieceBaseModel>[];

  for (List<PieceOrJustActionable> pieceList in _inGameBoardStatus) {
    for (PieceOrJustActionable piece in pieceList) {
      if (piece is PieceBaseModel) {
        if (piece.team == Team.blue) {
          blueList.add(piece);
        }
      }
    }
  }

  return blueList;
}
