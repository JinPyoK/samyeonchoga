import 'package:samyeonchoga/model/in_game/piece_base_model.dart';

List<List<PieceOrStatusDummy>> _inGameBoardStatus = List.generate(
    9, (_) => List<PieceOrStatusDummy>.generate(10, (_) => StatusDummy()));

PieceOrStatusDummy getStatus(int x, int y) => _inGameBoardStatus[x][y];

void changeStatus(int x, int y, PieceOrStatusDummy pieceModel) =>
    _inGameBoardStatus[x][y] = pieceModel;
