import 'package:samyeonchoga/model/in_game/blue_piece/blue_cha_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_king_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_ma_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_po_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_sa_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_sang_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_zol_model.dart';
import 'package:samyeonchoga/model/in_game/piece_actionable_model.dart';
import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_byung_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_cha_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_ma_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_po_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_sang_model.dart';

final class InGameBoardStatus {
  List<List<PieceOrJustActionable>> boardStatus = List.generate(
    9,
    (x) => List<PieceOrJustActionable>.generate(
      10,
      (y) => PieceActionableModel(targetX: x, targetY: y, targetValue: 0),
    ),
  );

  void initStatusBoard() {
    boardStatus = List.generate(
      9,
      (x) => List<PieceOrJustActionable>.generate(
        10,
        (y) => PieceActionableModel(targetX: x, targetY: y, targetValue: 0),
      ),
    );
  }

  PieceOrJustActionable getStatus(int x, int y) => boardStatus[x][y];

  void changeStatus(int x, int y, PieceOrJustActionable pieceModel) =>
      boardStatus[x][y] = pieceModel;

  /// 한나라의 행마 조사 (미니맥스, 장군 체크)
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

  /// 한나라의 기물 개수 -> 한나라 기물이 50개 이상이면 게임 종료
  /// 한나라가 공격을 안하고 무한 반복수 하는 경우를 방비
  int getNumOfRed() {
    final redList = getRedAll();

    return redList.length;
  }

  /// 초나라의 행마 조사 (미니맥스)
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

  /// 게임 저장 데이터 수집
  List<String> refinePieceModelForSave() {
    final inGameSaveDataList = <String>[];

    for (List<PieceOrJustActionable> statusList in boardStatus) {
      for (PieceOrJustActionable status in statusList) {
        if (status is PieceBaseModel) {
          inGameSaveDataList.add(status.team.name);
          inGameSaveDataList.add(status.pieceType.name);
          inGameSaveDataList.add(status.x.toString());
          inGameSaveDataList.add(status.y.toString());
        }
      }
    }

    return inGameSaveDataList;
  }

  /// 저장된 게임 데이터로 초기화
  void initStatusBoardWithSavedData(List<String> savedData) {
    initStatusBoard();

    for (int i = 2; i < savedData.length; i += 4) {
      late PieceBaseModel pieceModel;

      final team = Team.values.byName(savedData[i + 0]);
      final pieceType = PieceType.values.byName(savedData[i + 1]);
      final x = int.parse(savedData[i + 2]);
      final y = int.parse(savedData[i + 3]);

      /// 초나라
      if (team == Team.blue) {
        if (pieceType == PieceType.king) {
          pieceModel = BlueKingModel(x: x, y: y);
        } else if (pieceType == PieceType.sa) {
          pieceModel = BlueSaModel(x: x, y: y);
        } else if (pieceType == PieceType.cha) {
          pieceModel = BlueChaModel(x: x, y: y);
        } else if (pieceType == PieceType.po) {
          pieceModel = BluePoModel(x: x, y: y);
        } else if (pieceType == PieceType.ma) {
          pieceModel = BlueMaModel(x: x, y: y);
        } else if (pieceType == PieceType.sang) {
          pieceModel = BlueSangModel(x: x, y: y);
        } else {
          pieceModel = BlueZolModel(x: x, y: y);
        }
      }
      /// 한나라
      else {
        if (pieceType == PieceType.cha) {
          pieceModel = RedChaModel(x: x, y: y);
        } else if (pieceType == PieceType.po) {
          pieceModel = RedPoModel(x: x, y: y);
        } else if (pieceType == PieceType.ma) {
          pieceModel = RedMaModel(x: x, y: y);
        } else if (pieceType == PieceType.sang) {
          pieceModel = RedSangModel(x: x, y: y);
        } else {
          pieceModel = RedByungModel(x: x, y: y);
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

  /// 저장된 게임 데이터로 초기화 (미니맥스)
  void boardStatusFromJsonList(List<Map<String, dynamic>> boardStatusJsonList) {
    initStatusBoard();

    for (Map<String, dynamic> boardStatusJson in boardStatusJsonList) {
      late PieceBaseModel pieceModel;

      /// 초나라
      if (boardStatusJson['team'] == Team.blue.name) {
        if (boardStatusJson['pieceType'] == PieceType.king.name) {
          pieceModel = BlueKingModel(
            x: boardStatusJson['x'],
            y: boardStatusJson['y'],
          );
        } else if (boardStatusJson['pieceType'] == PieceType.sa.name) {
          pieceModel = BlueSaModel(
            x: boardStatusJson['x'],
            y: boardStatusJson['y'],
          );
        } else if (boardStatusJson['pieceType'] == PieceType.cha.name) {
          pieceModel = BlueChaModel(
            x: boardStatusJson['x'],
            y: boardStatusJson['y'],
          );
        } else if (boardStatusJson['pieceType'] == PieceType.po.name) {
          pieceModel = BluePoModel(
            x: boardStatusJson['x'],
            y: boardStatusJson['y'],
          );
        } else if (boardStatusJson['pieceType'] == PieceType.ma.name) {
          pieceModel = BlueMaModel(
            x: boardStatusJson['x'],
            y: boardStatusJson['y'],
          );
        } else if (boardStatusJson['pieceType'] == PieceType.sang.name) {
          pieceModel = BlueSangModel(
            x: boardStatusJson['x'],
            y: boardStatusJson['y'],
          );
        } else if (boardStatusJson['pieceType'] == PieceType.zol.name) {
          pieceModel = BlueZolModel(
            x: boardStatusJson['x'],
            y: boardStatusJson['y'],
          );
        }
      }
      /// 한나라
      else {
        if (boardStatusJson['pieceType'] == PieceType.cha.name) {
          pieceModel = RedChaModel(
            x: boardStatusJson['x'],
            y: boardStatusJson['y'],
          );
        } else if (boardStatusJson['pieceType'] == PieceType.po.name) {
          pieceModel = RedPoModel(
            x: boardStatusJson['x'],
            y: boardStatusJson['y'],
          );
        } else if (boardStatusJson['pieceType'] == PieceType.ma.name) {
          pieceModel = RedMaModel(
            x: boardStatusJson['x'],
            y: boardStatusJson['y'],
          );
        } else if (boardStatusJson['pieceType'] == PieceType.sang.name) {
          pieceModel = RedSangModel(
            x: boardStatusJson['x'],
            y: boardStatusJson['y'],
          );
        } else if (boardStatusJson['pieceType'] == PieceType.byung.name) {
          pieceModel = RedByungModel(
            x: boardStatusJson['x'],
            y: boardStatusJson['y'],
          );
        }
      }
      changeStatus(pieceModel.x, pieceModel.y, pieceModel);
    }
  }
}

InGameBoardStatus inGameBoardStatus = InGameBoardStatus();
