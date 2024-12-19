import 'package:samyeonchoga/model/in_game/blue_piece/blue_cha_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_ma_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_po_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_sang_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_zol_model.dart';
import 'package:samyeonchoga/model/in_game/in_game_save_model.dart';
import 'package:samyeonchoga/model/in_game/piece_actionable_model.dart';
import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_byung_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_cha_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_king_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_ma_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_po_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_sa_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_sang_model.dart';

List<List<PieceOrJustActionable>> _inGameBoardStatus = List.generate(
    9,
    (x) => List<PieceOrJustActionable>.generate(10,
        (y) => PieceActionableModel(targetX: x, targetY: y, targetValue: 0)));

void initStatusBoard() {
  _inGameBoardStatus = List.generate(
      9,
      (x) => List<PieceOrJustActionable>.generate(10,
          (y) => PieceActionableModel(targetX: x, targetY: y, targetValue: 0)));
}

List<List<PieceOrJustActionable>> getWholeStatus() => _inGameBoardStatus;

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

/// 게임 저장 데이터 수집
List<InGameSaveModel> refinePieceModelForSave() {
  final inGameSaveDataList = <InGameSaveModel>[];

  for (List<PieceOrJustActionable> statusList in _inGameBoardStatus) {
    for (PieceOrJustActionable status in statusList) {
      if (status is PieceBaseModel) {
        final refineData = InGameSaveModel(
          team: status.team,
          pieceType: status.pieceType,
          x: status.x,
          y: status.y,
        );

        inGameSaveDataList.add(refineData);
      }
    }
  }

  return inGameSaveDataList;
}

/// 저장된 게임 데이터로 초기화
void initStatusBoardWithSavedData(List<InGameSaveModel> savedData) {
  initStatusBoard();

  for (InGameSaveModel inGameSaveData in savedData) {
    late PieceBaseModel pieceModel;

    /// 한나라
    if (inGameSaveData.team == Team.red) {
      if (inGameSaveData.pieceType == PieceType.king) {
        pieceModel = RedKingModel(x: inGameSaveData.x, y: inGameSaveData.y);
      } else if (inGameSaveData.pieceType == PieceType.sa) {
        pieceModel = RedSaModel(x: inGameSaveData.x, y: inGameSaveData.y);
      } else if (inGameSaveData.pieceType == PieceType.cha) {
        pieceModel = RedChaModel(x: inGameSaveData.x, y: inGameSaveData.y);
      } else if (inGameSaveData.pieceType == PieceType.po) {
        pieceModel = RedPoModel(x: inGameSaveData.x, y: inGameSaveData.y);
      } else if (inGameSaveData.pieceType == PieceType.ma) {
        pieceModel = RedMaModel(x: inGameSaveData.x, y: inGameSaveData.y);
      } else if (inGameSaveData.pieceType == PieceType.sang) {
        pieceModel = RedSangModel(x: inGameSaveData.x, y: inGameSaveData.y);
      } else {
        pieceModel = RedByungModel(x: inGameSaveData.x, y: inGameSaveData.y);
      }
    }

    /// 초나라
    else {
      if (inGameSaveData.pieceType == PieceType.cha) {
        pieceModel = BlueChaModel(x: inGameSaveData.x, y: inGameSaveData.y);
      } else if (inGameSaveData.pieceType == PieceType.po) {
        pieceModel = BluePoModel(x: inGameSaveData.x, y: inGameSaveData.y);
      } else if (inGameSaveData.pieceType == PieceType.ma) {
        pieceModel = BlueMaModel(x: inGameSaveData.x, y: inGameSaveData.y);
      } else if (inGameSaveData.pieceType == PieceType.sang) {
        pieceModel = BlueSangModel(x: inGameSaveData.x, y: inGameSaveData.y);
      } else {
        pieceModel = BlueZolModel(x: inGameSaveData.x, y: inGameSaveData.y);
      }
    }
    changeStatus(pieceModel.x, pieceModel.y, pieceModel);
  }
}
