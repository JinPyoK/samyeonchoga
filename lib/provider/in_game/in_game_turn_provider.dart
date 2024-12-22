import 'dart:math' hide log;

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_cha_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_ma_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_po_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_sang_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_zol_model.dart';
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

part 'in_game_turn_provider.g.dart';

@Riverpod()
final class InGameTurn extends _$InGameTurn {
  @override
  bool build() {
    return true;
  }

  void changeTurn() async {
    state = !state;

    /// 초나라의 턴이라면 라운드를 증가시키고 초나라 착수
    if (state == false) {
      ref.read(inGameRoundProvider.notifier).nextRound();

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
            showCustomDialog(
              globalContext!,
              const InGameResult(),
              defaultAction: false,
            );
          }
          return;
        }
      }

      /// 초나라 착수 후 장군 체크
      determineIfJanggoon();

      state = true;
    }
  }

  void _blueSpawn() {
    final round = ref.read(inGameRoundProvider);

    /// 초나라 알고리즘 강화
    if (round == 10) {
      ref.read(inGameSystemNotificationProvider.notifier).notifyBlueUpgrade(1);
    } else if (round == 20) {
      ref.read(inGameSystemNotificationProvider.notifier).notifyBlueUpgrade(2);
    } else if (round == 30) {
      ref.read(inGameSystemNotificationProvider.notifier).notifyBlueUpgrade(3);
    } else if (round == 40) {
      ref.read(inGameSystemNotificationProvider.notifier).notifyBlueUpgrade(4);
    } else if (round == 50) {
      ref.read(inGameSystemNotificationProvider.notifier).notifyBlueUpgrade(5);
    }

    /// 라운드 구간별 3 라운드 또는 5라운드 마다 초나라 기물 부활
    /// 1 ~ 9라운드
    if (round < 10) {
      if (round % 3 != 0) {
        return;
      }
    }

    /// 10 ~ 19 라운드
    else if (round <= 20) {
      if (round % 5 != 0) {
        return;
      }
    }

    /// 20 ~ 29 라운드
    else if (round < 30) {
      if (round % 3 != 0) {
        return;
      }
    }

    /// 30 ~ 39 라운드
    else if (round <= 40) {
      if (round % 5 != 0) {
        return;
      }
    }

    /// 40 ~ 49 라운드
    else if (round < 50) {
      if (round % 3 != 0) {
        return;
      }
    }

    /// 50 ~ 라운드
    else {
      if (round % 3 != 0) {
        return;
      }
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

    /// 차: 5%
    if (pieceTypeNumberRange >= 0 && pieceTypeNumberRange < 5) {
      spawnBluePiece =
          BlueChaModel(x: bluePiecePlace.targetX, y: bluePiecePlace.targetY);
    }

    /// 포: 10%
    else if (pieceTypeNumberRange >= 5 && pieceTypeNumberRange < 15) {
      spawnBluePiece =
          BluePoModel(x: bluePiecePlace.targetX, y: bluePiecePlace.targetY);
    }

    /// 마: 15%
    else if (pieceTypeNumberRange >= 15 && pieceTypeNumberRange < 30) {
      spawnBluePiece =
          BlueMaModel(x: bluePiecePlace.targetX, y: bluePiecePlace.targetY);
    }

    /// 상: 30%
    else if (pieceTypeNumberRange >= 30 && pieceTypeNumberRange < 60) {
      spawnBluePiece =
          BlueSangModel(x: bluePiecePlace.targetX, y: bluePiecePlace.targetY);
    }

    /// 졸: 40%
    else {
      spawnBluePiece =
          BlueZolModel(x: bluePiecePlace.targetX, y: bluePiecePlace.targetY);
    }

    ref.read(inGamePieceSetProvider.notifier).spawnPiece(spawnBluePiece);
  }

  Future<PieceActionableModel?> _blueAction() async {
    final minimaxResult = await _minimaxIsolate(100);

    if (minimaxResult.isEmpty) {
      return null;
    }

    final pieceX = minimaxResult[0];
    final pieceY = minimaxResult[1];
    final targetX = minimaxResult[2];
    final targetY = minimaxResult[3];
    final targetValue = minimaxResult[4];

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

      bluePiece.searchActionable();
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

  Future<List<int>> _minimaxIsolate(int treeDepth) async {
    return await compute(
        _minimax, [treeDepth, inGameBoardStatus.boardStatusToJsonList(), 0]);
  }
}

/// 미니맥스 알고리즘으로 교체해야 하나, 지금은 랜덤으로 하기
/// return List[선정 기물 모델x, y, 액셔너블x, y, 타겟밸류]
List<int> _minimax(List<dynamic> params) {
  /// 트리의 최종 깊이
  final treeDepth = params[0] as int;

  /// 상태 보드 Json 직렬화된 상태
  final statusJsonList = params[1] as List<Map<String, dynamic>>;

  /// 현재 노드의 깊이
  final nodeDepth = params[2] as int;

  /// Json을 다시 역직렬화 하여 상태 보드 만들기
  final minimaxBoardStatus = InGameBoardStatus()
    ..boardStatusFromJsonList(statusJsonList);

  /// 노드의 깊이가 홀수이면 한, 짝수이면 초 기물들 조사
  final blueList = minimaxBoardStatus.getBlueAll();

  if (blueList.isEmpty) {
    return [];
  }

  for (PieceBaseModel piece in blueList) {
    piece.searchActionable();
    if (piece.pieceActionable.isNotEmpty) {
      return [
        piece.x,
        piece.y,
        piece.pieceActionable[0].targetX,
        piece.pieceActionable[0].targetY,
        piece.pieceActionable[0].targetValue,
      ];
    }
  }

  return [];
}
