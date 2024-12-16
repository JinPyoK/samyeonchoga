import 'package:samyeonchoga/model/in_game/piece_actionable_model.dart';
import 'package:samyeonchoga/model/in_game/piece_base_model.dart';

List<List<PieceOrJustActionable>> _inGameBoardStatus = List.generate(
    9,
    (x) => List<PieceOrJustActionable>.generate(10,
        (y) => PieceActionableModel(targetX: x, targetY: y, targetValue: 0)));

PieceOrJustActionable getStatus(int x, int y) => _inGameBoardStatus[x][y];

void changeStatus(int x, int y, PieceOrJustActionable pieceModel) =>
    _inGameBoardStatus[x][y] = pieceModel;
