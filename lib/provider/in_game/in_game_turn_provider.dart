import 'dart:math' hide log;

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_cha_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_ma_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_po_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_sang_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_zol_model.dart';
import 'package:samyeonchoga/model/in_game/minimax_node_tree.dart';
import 'package:samyeonchoga/model/in_game/piece_actionable_model.dart';
import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/provider/context/global_context.dart';
import 'package:samyeonchoga/provider/in_game/in_game_board_status.dart';
import 'package:samyeonchoga/provider/in_game/in_game_piece_set_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_round_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_selected_piece_model.dart';
import 'package:samyeonchoga/provider/in_game/in_game_system_notification_provider.dart';
import 'package:samyeonchoga/ui/audio/controller/sound_play.dart';
import 'package:samyeonchoga/ui/common/controller/show_custom_dialog.dart';
import 'package:samyeonchoga/ui/in_game/widget/in_game_result.dart';

part 'in_game_blue_minimax.dart';

part 'in_game_turn_provider.g.dart';

@Riverpod()
final class InGameTurn extends _$InGameTurn {
  @override
  bool build() {
    return true;
  }

  Future<void> changeTurn() async {
    ref.read(inGameRoundProvider.notifier).nextRound();

    state = !state;

    /// 초나라 착수
    if (state == false) {
      /// 시스템 노티피케이션 리스트 비워주기
      ref
          .read(inGameSystemNotificationProvider.notifier)
          .clearNotificationList();

      /// 초나라 기물 부활
      _blueSpawn();

      /// 초나라 착수
      final PieceActionableModel? targetPieceActionable = await _blueAction();

      /// 만약 초나라가 왕을 먹었다면 게임 종료
      if (targetPieceActionable != null) {
        if (targetPieceActionable.targetValue == 1000) {
          if (globalContext!.mounted) {
            Future.delayed(const Duration(seconds: 1), () {
              showCustomDialog(
                globalContext!,
                const InGameResult(),
                defaultAction: false,
              );
            });
          }
          return;
        }
      }

      /// 초나라 착수 후 장군 체크
      determineIfJanggoon();

      changeTurn();
    }
  }

  void _blueSpawn() {
    final round = ref.read(inGameRoundProvider);

    /// 초나라 알고리즘 강화
    if (round == 20) {
      upgradeBlue(1);
      ref.read(inGameSystemNotificationProvider.notifier).notifyBlueUpgrade(1);
    } else if (round == 40) {
      upgradeBlue(2);
      ref.read(inGameSystemNotificationProvider.notifier).notifyBlueUpgrade(2);
    } else if (round == 60) {
      upgradeBlue(3);
      ref.read(inGameSystemNotificationProvider.notifier).notifyBlueUpgrade(3);
    } else if (round == 80) {
      upgradeBlue(4);
      ref.read(inGameSystemNotificationProvider.notifier).notifyBlueUpgrade(4);
    } else if (round == 100) {
      upgradeBlue(5);
      ref.read(inGameSystemNotificationProvider.notifier).notifyBlueUpgrade(5);
    }

    /// spawnRound 마다 초나라 기물 부활
    if (round % _spawnRound != 0) {
      return;
    }

    final blueSpawnPositionList = <PieceActionableModel>[];

    /// 초나라 기물 부활 자리 찾기
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 4; j++) {
        final bluePlace = inGameBoardStatus.getStatus(i, j);
        if (bluePlace is PieceActionableModel) {
          blueSpawnPositionList.add(bluePlace);
        }
      }
    }

    /// 부활할 자리가 없으면 함수 종료
    if (blueSpawnPositionList.isEmpty) {
      return;
    }

    final pieceTypeNumberRange = Random().nextInt(100);
    final blueSpawnPositionNumber =
        Random().nextInt(blueSpawnPositionList.length);

    late PieceBaseModel spawnBluePiece;
    final bluePiecePlace = blueSpawnPositionList[blueSpawnPositionNumber];

    /// 기물 부활 확률
    if (pieceTypeNumberRange >= _chaSpawnStartRange &&
        pieceTypeNumberRange < _chaSpawnEndRange) {
      spawnBluePiece =
          BlueChaModel(x: bluePiecePlace.targetX, y: bluePiecePlace.targetY);
    } else if (pieceTypeNumberRange >= _poSpawnStartRange &&
        pieceTypeNumberRange < _poSpawnEndRange) {
      spawnBluePiece =
          BluePoModel(x: bluePiecePlace.targetX, y: bluePiecePlace.targetY);
    } else if (pieceTypeNumberRange >= _maSpawnStartRange &&
        pieceTypeNumberRange < _maSpawnEndRange) {
      spawnBluePiece =
          BlueMaModel(x: bluePiecePlace.targetX, y: bluePiecePlace.targetY);
    } else if (pieceTypeNumberRange >= _sangSpawnStartRange &&
        pieceTypeNumberRange < _sangSpawnEndRange) {
      spawnBluePiece =
          BlueSangModel(x: bluePiecePlace.targetX, y: bluePiecePlace.targetY);
    } else {
      spawnBluePiece =
          BlueZolModel(x: bluePiecePlace.targetX, y: bluePiecePlace.targetY);
    }

    ref.read(inGamePieceSetProvider.notifier).spawnPiece(spawnBluePiece);
  }

  Future<PieceActionableModel?> _blueAction() async {
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

    /// 움직인 자리에 한나라 기물이 있다면 제거하기
    final status = inGameBoardStatus.getStatus(
        pieceActionable.targetX, pieceActionable.targetY);
    if (status is PieceBaseModel) {
      if (status.team == Team.red) {
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

    /// 초나라의 기물 모두 조사
    final blueList = inGameBoardStatus.getBlueAll();

    for (PieceBaseModel piece in blueList) {
      final bluePiece = piece as BluePieceBaseModel;

      bluePiece.searchActionable(inGameBoardStatus);
      bluePiece.doesThisPieceCallJanggoon();

      bluePiece.setStateThisPiece!(() {});

      if (bluePiece.isTargetingKing) {
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

int _spawnRound = 4;

int _chaSpawnStartRange = 0;
int _chaSpawnEndRange = 5;

int _poSpawnStartRange = 5;
int _poSpawnEndRange = 15;

int _maSpawnStartRange = 15;
int _maSpawnEndRange = 30;

int _sangSpawnStartRange = 30;
int _sangSpawnEndRange = 60;

void upgradeBlue(int level) {
  switch (level) {
    case 0:
      _minimaxTreeDepth = 3;

      _spawnRound = 8;

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

      _spawnRound = 4;

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

      _spawnRound = 8;

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

      _spawnRound = 4;

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

      _spawnRound = 8;

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

      _spawnRound = 4;

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
