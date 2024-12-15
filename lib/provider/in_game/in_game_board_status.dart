import 'package:samyeonchoga/model/in_game/piece_base_model.dart';

List<List<PieceBaseModel?>> _inGameBoardStatus =
    List.generate(9, (_) => List<PieceBaseModel?>.generate(10, (_) => null));

PieceBaseModel? getStatus(int x, int y) => _inGameBoardStatus[x][y];

void changeStatus(int x, int y, PieceBaseModel? pieceModel) =>
    _inGameBoardStatus[x][y] = pieceModel;
