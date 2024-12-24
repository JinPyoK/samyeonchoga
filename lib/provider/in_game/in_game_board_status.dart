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

final class InGameBoardStatus {
  List<List<PieceOrJustActionable>> boardStatus = List.generate(
      9,
      (x) => List<PieceOrJustActionable>.generate(10,
          (y) => PieceActionableModel(targetX: x, targetY: y, targetValue: 0)));

  void initStatusBoard() {
    boardStatus = List.generate(
        9,
        (x) => List<PieceOrJustActionable>.generate(
            10,
            (y) =>
                PieceActionableModel(targetX: x, targetY: y, targetValue: 0)));
  }

  PieceOrJustActionable getStatus(int x, int y) => boardStatus[x][y];

  void changeStatus(int x, int y, PieceOrJustActionable pieceModel) =>
      boardStatus[x][y] = pieceModel;

  /// 초나라의 행마 조사 (미니맥스, 장군 체크)
  List<PieceBaseModel> getBlueAll() {
    final blueList = <PieceBaseModel>[];

    for (List<PieceOrJustActionable> pieceList in boardStatus) {
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

  /// 한나라의 행마 조사 (미니맥스)
  List<PieceBaseModel> getRedAll() {
    final redList = <PieceBaseModel>[];

    for (List<PieceOrJustActionable> pieceList in boardStatus) {
      for (PieceOrJustActionable piece in pieceList) {
        if (piece is PieceBaseModel) {
          if (piece.team == Team.red) {
            redList.add(piece);
          }
        }
      }
    }

    return redList;
  }

  /// 게임 저장 데이터 수집
  List<InGameSaveModel> refinePieceModelForSave() {
    final inGameSaveDataList = <InGameSaveModel>[];

    for (List<PieceOrJustActionable> statusList in boardStatus) {
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

  /// 미니맥스 Isolate 데이터 전달 목적
  List<Map<String, dynamic>> boardStatusToJsonList() {
    final boardStatusJsonList = <Map<String, dynamic>>[];

    for (List<PieceOrJustActionable> statusList in boardStatus) {
      for (PieceOrJustActionable status in statusList) {
        if (status is PieceBaseModel) {
          final refineData = {
            'team': status.team.name,
            'pieceType': status.pieceType.name,
            'x': status.x,
            'y': status.y,
          };

          boardStatusJsonList.add(refineData);
        }
      }
    }

    return boardStatusJsonList;
  }

  /// 저장된 게임 데이터로 초기화
  void boardStatusFromJsonList(List<Map<String, dynamic>> boardStatusJsonList) {
    initStatusBoard();

    for (Map<String, dynamic> boardStatusJson in boardStatusJsonList) {
      late PieceBaseModel pieceModel;

      /// 한나라
      if (boardStatusJson['team'] == Team.red.name) {
        if (boardStatusJson['pieceType'] == PieceType.king.name) {
          pieceModel =
              RedKingModel(x: boardStatusJson['x'], y: boardStatusJson['y']);
        } else if (boardStatusJson['pieceType'] == PieceType.sa.name) {
          pieceModel =
              RedSaModel(x: boardStatusJson['x'], y: boardStatusJson['y']);
        } else if (boardStatusJson['pieceType'] == PieceType.cha.name) {
          pieceModel =
              RedChaModel(x: boardStatusJson['x'], y: boardStatusJson['y']);
        } else if (boardStatusJson['pieceType'] == PieceType.po.name) {
          pieceModel =
              RedPoModel(x: boardStatusJson['x'], y: boardStatusJson['y']);
        } else if (boardStatusJson['pieceType'] == PieceType.ma.name) {
          pieceModel =
              RedMaModel(x: boardStatusJson['x'], y: boardStatusJson['y']);
        } else if (boardStatusJson['pieceType'] == PieceType.sang.name) {
          pieceModel =
              RedSangModel(x: boardStatusJson['x'], y: boardStatusJson['y']);
        } else {
          pieceModel =
              RedByungModel(x: boardStatusJson['x'], y: boardStatusJson['y']);
        }
      }

      /// 초나라
      else {
        if (boardStatusJson['pieceType'] == PieceType.cha.name) {
          pieceModel =
              BlueChaModel(x: boardStatusJson['x'], y: boardStatusJson['y']);
        } else if (boardStatusJson['pieceType'] == PieceType.po.name) {
          pieceModel =
              BluePoModel(x: boardStatusJson['x'], y: boardStatusJson['y']);
        } else if (boardStatusJson['pieceType'] == PieceType.ma.name) {
          pieceModel =
              BlueMaModel(x: boardStatusJson['x'], y: boardStatusJson['y']);
        } else if (boardStatusJson['pieceType'] == PieceType.sang.name) {
          pieceModel =
              BlueSangModel(x: boardStatusJson['x'], y: boardStatusJson['y']);
        } else {
          pieceModel =
              BlueZolModel(x: boardStatusJson['x'], y: boardStatusJson['y']);
        }
      }
      changeStatus(pieceModel.x, pieceModel.y, pieceModel);
    }
  }
}

InGameBoardStatus inGameBoardStatus = InGameBoardStatus();
