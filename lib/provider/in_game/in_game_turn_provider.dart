import 'dart:math' hide log;

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samyeonchoga/model/in_game/minimax_node_tree.dart';
import 'package:samyeonchoga/model/in_game/piece_actionable_model.dart';
import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_byung_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_cha_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_ma_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_po_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_sang_model.dart';
import 'package:samyeonchoga/provider/context/global_context.dart';
import 'package:samyeonchoga/provider/in_game/in_game_board_status.dart';
import 'package:samyeonchoga/provider/in_game/in_game_move_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_piece_set_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_selected_piece_model.dart';
import 'package:samyeonchoga/provider/in_game/in_game_system_notification_provider.dart';
import 'package:samyeonchoga/ui/audio/controller/sound_play.dart';
import 'package:samyeonchoga/ui/common/controller/show_custom_dialog.dart';
import 'package:samyeonchoga/ui/in_game/widget/in_game_result.dart';

part 'in_game_red_minimax.dart';
part 'in_game_turn_provider.g.dart';

@Riverpod()
final class InGameTurn extends _$InGameTurn {
  @override
  bool build() {
    return true;
  }

  Future<void> changeTurn() async {
    ref.read(inGameMoveProvider.notifier).nextMove();

    state = !state;

    /// 한나라 착수
    if (state == false) {
      /// 시스템 노티피케이션 리스트 비워주기
      ref
          .read(inGameSystemNotificationProvider.notifier)
          .clearNotificationList();

      /// 한나라 기물 부활
      _redSpawn();

      /// 한나라 기물의 수가 70을 넘으면 게임 종료
      if (inGameBoardStatus.getNumOfRed() > 70) {
        if (globalContext!.mounted) {
          Future.delayed(const Duration(seconds: 1), () {
            showCustomDialog(
              globalContext!,
              const InGameResult(reason: 1),
              defaultAction: false,
            );
          });
        }
        return;
      }

      /// 한나라 착수
      final PieceActionableModel? targetPieceActionable = await _redAction();

      /// 만약 한나라가 초나라의 왕을 먹었다면 게임 종료
      if (targetPieceActionable != null) {
        if (targetPieceActionable.targetValue == 1000) {
          if (globalContext!.mounted) {
            Future.delayed(const Duration(seconds: 1), () {
              showCustomDialog(
                globalContext!,
                const InGameResult(reason: 0),
                defaultAction: false,
              );
            });
          }
          return;
        }
      }

      /// 한나라 착수 후 장군 체크
      determineIfJanggoon();

      changeTurn();
    }
  }

  void _redSpawn() {
    final move = ref.read(inGameMoveProvider);

    /// 한나라 알고리즘 강화
    if (move == 20) {
      upgradeRed(1);
      ref.read(inGameSystemNotificationProvider.notifier).notifyRedUpgrade(1);
    } else if (move == 40) {
      upgradeRed(2);
      ref.read(inGameSystemNotificationProvider.notifier).notifyRedUpgrade(2);
    } else if (move == 60) {
      upgradeRed(3);
      ref.read(inGameSystemNotificationProvider.notifier).notifyRedUpgrade(3);
    } else if (move == 80) {
      upgradeRed(4);
      ref.read(inGameSystemNotificationProvider.notifier).notifyRedUpgrade(4);
    } else if (move == 100) {
      upgradeRed(5);
      ref.read(inGameSystemNotificationProvider.notifier).notifyRedUpgrade(5);
    }

    /// spawnMove 마다 초나라 기물 부활
    if (move % _spawnMove != 0) {
      return;
    }

    final redSpawnPositionList = <PieceActionableModel>[];

    /// 한나라 기물 부활 자리 찾기
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 4; j++) {
        final bluePlace = inGameBoardStatus.getStatus(i, j);
        if (bluePlace is PieceActionableModel) {
          redSpawnPositionList.add(bluePlace);
        }
      }
    }

    /// 한나라 진영에 부활할 자리가 없으면 초나라 진영 포함 나머지 구역 조사
    if (redSpawnPositionList.isEmpty) {
      for (int i = 0; i < 9; i++) {
        for (int j = 4; j < 10; j++) {
          final bluePlace = inGameBoardStatus.getStatus(i, j);
          if (bluePlace is PieceActionableModel) {
            redSpawnPositionList.add(bluePlace);
          }
        }
      }
    }

    /// 그래도 없으면 함수 종료
    if (redSpawnPositionList.isEmpty) {
      return;
    }

    final pieceTypeNumberRange = Random().nextInt(100);
    final redSpawnPositionNumber =
        Random().nextInt(redSpawnPositionList.length);

    late PieceBaseModel spawnRedPiece;
    final redPiecePlace = redSpawnPositionList[redSpawnPositionNumber];

    /// 기물 부활 확률
    if (pieceTypeNumberRange >= _chaSpawnStartRange &&
        pieceTypeNumberRange < _chaSpawnEndRange) {
      spawnRedPiece =
          RedChaModel(x: redPiecePlace.targetX, y: redPiecePlace.targetY);
    } else if (pieceTypeNumberRange >= _poSpawnStartRange &&
        pieceTypeNumberRange < _poSpawnEndRange) {
      spawnRedPiece =
          RedPoModel(x: redPiecePlace.targetX, y: redPiecePlace.targetY);
    } else if (pieceTypeNumberRange >= _maSpawnStartRange &&
        pieceTypeNumberRange < _maSpawnEndRange) {
      spawnRedPiece =
          RedMaModel(x: redPiecePlace.targetX, y: redPiecePlace.targetY);
    } else if (pieceTypeNumberRange >= _sangSpawnStartRange &&
        pieceTypeNumberRange < _sangSpawnEndRange) {
      spawnRedPiece =
          RedSangModel(x: redPiecePlace.targetX, y: redPiecePlace.targetY);
    } else {
      spawnRedPiece =
          RedByungModel(x: redPiecePlace.targetX, y: redPiecePlace.targetY);
    }

    ref.read(inGamePieceSetProvider.notifier).spawnPiece(spawnRedPiece);
  }

  Future<PieceActionableModel?> _redAction() async {
    final minimaxResult = await _minimaxIsolate(_minimaxTreeDepth);

    if (minimaxResult.isEmpty) {
      return null;
    }

    final pieceX = minimaxResult[0];
    final pieceY = minimaxResult[1];
    final targetX = minimaxResult[2];
    final targetY = minimaxResult[3];
    final targetValue = minimaxResult[4];

    if (pieceX == null ||
        pieceY == null ||
        targetX == null ||
        targetY == null ||
        targetValue == null) {
      return null;
    }

    final piece = inGameBoardStatus.getStatus(pieceX, pieceY) as PieceBaseModel;

    final pieceActionable = PieceActionableModel(
        targetX: targetX, targetY: targetY, targetValue: targetValue);

    /// 기물 착수 ui 구현 위해서
    if (lastTurnPiece != null) {
      lastTurnPiece!.justTurn = false;
      lastTurnPiece!.setStateThisPiece!(() {});
    }

    lastTurnPiece = piece;
    piece.justTurn = true;

    /// 보드 상태 변경
    inGameBoardStatus.changeStatus(
      piece.x,
      piece.y,
      PieceActionableModel(
        targetX: piece.x,
        targetY: piece.y,
        targetValue: 0,
      ),
    );

    /// 움직인 자리에 초나라 기물이 있다면 제거하기
    final status = inGameBoardStatus.getStatus(
        pieceActionable.targetX, pieceActionable.targetY);
    if (status is PieceBaseModel) {
      if (status.team == Team.blue) {
        ref.read(inGamePieceSetProvider.notifier).removePiece(pieceActionable);
      }
    }

    inGameBoardStatus.changeStatus(
        pieceActionable.targetX, pieceActionable.targetY, piece);

    /// 기물 착수
    piece.x = pieceActionable.targetX;
    piece.y = pieceActionable.targetY;
    piece.setStateThisPiece!(() {});

    makePieceMoveSound();

    return pieceActionable;
  }

  void determineIfJanggoon() {
    bool targetKing = false;

    /// 한나라의 기물 모두 조사
    final redList = inGameBoardStatus.getRedAll();

    for (PieceBaseModel piece in redList) {
      final redPiece = piece as RedPieceBaseModel;

      redPiece.searchActionable(inGameBoardStatus);
      redPiece.doesThisPieceCallJanggoon();

      redPiece.setStateThisPiece!(() {});

      if (redPiece.isTargetingKing) {
        targetKing = true;
      }
    }

    if (targetKing) {
      ref.read(inGameSystemNotificationProvider.notifier).notifyJanggoon();
    }
  }

  Future<List<int?>> _minimaxIsolate(int treeDepth) async {
    return await compute(
        _minimax, [treeDepth, inGameBoardStatus.boardStatusToJsonList(), 0]);
  }
}

int _spawnMove = 4;

int _chaSpawnStartRange = 0;
int _chaSpawnEndRange = 5;

int _poSpawnStartRange = 5;
int _poSpawnEndRange = 15;

int _maSpawnStartRange = 15;
int _maSpawnEndRange = 30;

int _sangSpawnStartRange = 30;
int _sangSpawnEndRange = 60;

/// 한나라 알고리즘 강화
void upgradeRed(int level) {
  switch (level) {
    case 0:
      _minimaxTreeDepth = 3;

      _spawnMove = 8;

      _chaSpawnStartRange = 0;
      _chaSpawnEndRange = 5;

      _poSpawnStartRange = 5;
      _poSpawnEndRange = 15;

      _maSpawnStartRange = 15;
      _maSpawnEndRange = 30;

      _sangSpawnStartRange = 30;
      _sangSpawnEndRange = 60;
      break;

    case 1:
      _minimaxTreeDepth = 3;

      _spawnMove = 4;

      _chaSpawnStartRange = 0;
      _chaSpawnEndRange = 5;

      _poSpawnStartRange = 5;
      _poSpawnEndRange = 15;

      _maSpawnStartRange = 15;
      _maSpawnEndRange = 30;

      _sangSpawnStartRange = 30;
      _sangSpawnEndRange = 70;
      break;

    case 2:
      _minimaxTreeDepth = 4;

      _spawnMove = 8;

      _chaSpawnStartRange = 0;
      _chaSpawnEndRange = 5;

      _poSpawnStartRange = 5;
      _poSpawnEndRange = 15;

      _maSpawnStartRange = 15;
      _maSpawnEndRange = 40;

      _sangSpawnStartRange = 40;
      _sangSpawnEndRange = 60;
      break;

    case 3:
      _minimaxTreeDepth = 4;

      _spawnMove = 4;

      _chaSpawnStartRange = 0;
      _chaSpawnEndRange = 10;

      _poSpawnStartRange = 10;
      _poSpawnEndRange = 30;

      _maSpawnStartRange = 30;
      _maSpawnEndRange = 60;

      _sangSpawnStartRange = 60;
      _sangSpawnEndRange = 80;
      break;

    case 4:
      _minimaxTreeDepth = 5;

      _spawnMove = 8;

      _chaSpawnStartRange = 0;
      _chaSpawnEndRange = 15;

      _poSpawnStartRange = 15;
      _poSpawnEndRange = 45;

      _maSpawnStartRange = 45;
      _maSpawnEndRange = 70;

      _sangSpawnStartRange = 70;
      _sangSpawnEndRange = 90;
      break;

    default:
      _minimaxTreeDepth = 5;

      _spawnMove = 4;

      _chaSpawnStartRange = 0;
      _chaSpawnEndRange = 25;

      _poSpawnStartRange = 25;
      _poSpawnEndRange = 45;

      _maSpawnStartRange = 45;
      _maSpawnEndRange = 75;

      _sangSpawnStartRange = 75;
      _sangSpawnEndRange = 90;
      break;
  }
}
