import 'dart:math';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
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
import 'package:samyeonchoga/provider/in_game/in_game_board_status.dart';
import 'package:samyeonchoga/provider/in_game/in_game_gold_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_move_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_red_status.dart';
import 'package:samyeonchoga/provider/in_game/in_game_save_entity.dart';
import 'package:samyeonchoga/provider/in_game/in_game_system_notification_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_turn_provider.dart';
import 'package:samyeonchoga/provider/lineup/lineup.dart';
import 'package:samyeonchoga/ui/audio/controller/sound_play.dart';
import 'package:samyeonchoga/ui/in_game/controller/get_gold_notification.dart';
import 'package:samyeonchoga/ui/in_game/controller/in_game_selected_piece_model.dart';
import 'package:samyeonchoga/ui/in_game/widget/in_game_piece.dart';

part 'in_game_piece_set_provider.g.dart';

Map<PieceType, int> _numOfPiece = {
  PieceType.king: 1,
  PieceType.cha: 2,
  PieceType.po: 2,
  PieceType.ma: 2,
  PieceType.sang: 2,
  PieceType.sa: 2,
  PieceType.zol: 5,
};

@Riverpod()
final class InGamePieceSet extends _$InGamePieceSet {
  @override
  List<InGamePiece> build() {
    return <InGamePiece>[];
  }

  void initPieceSet() {
    /// 상태보드 초기화
    inGameBoardStatus.initStatusBoard();

    inGameRedStatusProvider.upgradeRed(0);

    selectedPieceModel = null;
    lastTurnPiece = null;

    _numOfPiece = {
      PieceType.king: 1,
      PieceType.cha: 2,
      PieceType.po: 2,
      PieceType.ma: 2,
      PieceType.sang: 2,
      PieceType.sa: 2,
      PieceType.zol: 5,
    };

    ref.read(inGameOnTheRopesProvider.notifier).initOnTheRopes();

    /// 초나라 포진 설정
    switch (lineup) {
      case Lineup.maSangMaSang:
        spawnPiece(BlueMaModel(x: 1, y: 9), true);
        spawnPiece(BlueSangModel(x: 2, y: 9), true);
        spawnPiece(BlueMaModel(x: 6, y: 9), true);
        spawnPiece(BlueSangModel(x: 7, y: 9), true);
        break;
      case Lineup.sangMaSangMa:
        spawnPiece(BlueSangModel(x: 1, y: 9), true);
        spawnPiece(BlueMaModel(x: 2, y: 9), true);
        spawnPiece(BlueSangModel(x: 6, y: 9), true);
        spawnPiece(BlueMaModel(x: 7, y: 9), true);
        break;
      case Lineup.maSangSangMa:
        spawnPiece(BlueMaModel(x: 1, y: 9), true);
        spawnPiece(BlueSangModel(x: 2, y: 9), true);
        spawnPiece(BlueSangModel(x: 6, y: 9), true);
        spawnPiece(BlueMaModel(x: 7, y: 9), true);
        break;
      default:
        spawnPiece(BlueSangModel(x: 1, y: 9), true);
        spawnPiece(BlueMaModel(x: 2, y: 9), true);
        spawnPiece(BlueMaModel(x: 6, y: 9), true);
        spawnPiece(BlueSangModel(x: 7, y: 9), true);
        break;
    }

    /// 초나라 기물 세팅
    spawnPiece(BlueKingModel(x: 4, y: 8), true);
    spawnPiece(BlueSaModel(x: 3, y: 9), true);
    spawnPiece(BlueSaModel(x: 5, y: 9), true);

    spawnPiece(BlueChaModel(x: 0, y: 9), true);
    spawnPiece(BlueChaModel(x: 8, y: 9), true);

    spawnPiece(BluePoModel(x: 1, y: 7), true);
    spawnPiece(BluePoModel(x: 7, y: 7), true);

    spawnPiece(BlueZolModel(x: 0, y: 6), true);
    spawnPiece(BlueZolModel(x: 2, y: 6), true);
    spawnPiece(BlueZolModel(x: 4, y: 6), true);
    spawnPiece(BlueZolModel(x: 6, y: 6), true);
    spawnPiece(BlueZolModel(x: 8, y: 6), true);

    final randomNumber = Random().nextInt(4);

    /// 한나라 포진 설정
    switch (randomNumber) {
      case 0:
        spawnPiece(RedMaModel(x: 1, y: 0), true);
        spawnPiece(RedSangModel(x: 2, y: 0), true);
        spawnPiece(RedMaModel(x: 6, y: 0), true);
        spawnPiece(RedSangModel(x: 7, y: 0), true);
        break;
      case 1:
        spawnPiece(RedSangModel(x: 1, y: 0), true);
        spawnPiece(RedMaModel(x: 2, y: 0), true);
        spawnPiece(RedSangModel(x: 6, y: 0), true);
        spawnPiece(RedMaModel(x: 7, y: 0), true);
        break;
      case 2:
        spawnPiece(RedMaModel(x: 1, y: 0), true);
        spawnPiece(RedSangModel(x: 2, y: 0), true);
        spawnPiece(RedSangModel(x: 6, y: 0), true);
        spawnPiece(RedMaModel(x: 7, y: 0), true);
        break;
      default:
        spawnPiece(RedSangModel(x: 1, y: 0), true);
        spawnPiece(RedMaModel(x: 2, y: 0), true);
        spawnPiece(RedMaModel(x: 6, y: 0), true);
        spawnPiece(RedSangModel(x: 7, y: 0), true);
        break;
    }

    /// 한나라 기물 세팅
    spawnPiece(RedByungModel(x: 0, y: 3), true);
    spawnPiece(RedByungModel(x: 2, y: 3), true);
    spawnPiece(RedByungModel(x: 4, y: 3), true);
    spawnPiece(RedByungModel(x: 6, y: 3), true);
    spawnPiece(RedByungModel(x: 8, y: 3), true);

    spawnPiece(RedPoModel(x: 1, y: 2), true);
    spawnPiece(RedPoModel(x: 7, y: 2), true);

    spawnPiece(RedChaModel(x: 0, y: 0), true);
    spawnPiece(RedChaModel(x: 8, y: 0), true);

    state = List.from(state);
    makeGameStartSound();
  }

  void initPieceWithSavedData() {
    ref.read(inGameGoldProvider.notifier).setInGameGold(inGameSave!.inGameGold);
    ref.read(inGameMoveProvider.notifier).setMove(inGameSave!.move);

    ref.read(inGameOnTheRopesProvider.notifier).initOnTheRopes();

    if (inGameSave!.move < 20) {
      inGameRedStatusProvider.upgradeRed(0);
    } else if (inGameSave!.move < 40) {
      inGameRedStatusProvider.upgradeRed(1);
    } else if (inGameSave!.move < 60) {
      inGameRedStatusProvider.upgradeRed(2);
    } else if (inGameSave!.move < 80) {
      inGameRedStatusProvider.upgradeRed(3);
    } else if (inGameSave!.move < 100) {
      inGameRedStatusProvider.upgradeRed(4);
    } else {
      inGameRedStatusProvider.upgradeRed(5);
    }

    inGameBoardStatus
        .initStatusBoardWithSavedData(inGameSave!.inGameSaveDataList);

    selectedPieceModel = null;
    lastTurnPiece = null;

    Map<PieceType, int> numOfPieceInit = {
      PieceType.king: 0,
      PieceType.cha: 0,
      PieceType.po: 0,
      PieceType.ma: 0,
      PieceType.sang: 0,
      PieceType.sa: 0,
      PieceType.zol: 0,
    };

    _numOfPiece = numOfPieceInit;

    final statusBoard = inGameBoardStatus.boardStatus;

    for (List<PieceOrJustActionable> statusList in statusBoard) {
      for (PieceOrJustActionable status in statusList) {
        if (status is PieceBaseModel) {
          spawnPiece(status, true);

          if (status.team == Team.blue) {
            _numOfPiece[status.pieceType] = _numOfPiece[status.pieceType]! + 1;
          }
        }
      }
    }

    state = List.from(state);

    makeGameStartSound();

    Future.delayed(const Duration(seconds: 1), () {
      ref.read(inGameTurnProvider.notifier).determineIfJanggoon();
    });
  }

  /// 기물 부활
  void spawnPiece(PieceBaseModel pieceModel, [bool isInit = false]) {
    /// ref.watch가 state가 변경될 때마다 위젯을 다시 빌드하게 하지만, state 자체가 변경된 횟수와 관계없이 최종적으로 변경된 상태에서만 빌드됩니다.
    /// Flutter와 Riverpod의 작동 방식에서 ref.watch는 state 객체가 변경되었을 때 반응하지만, 상태 변경이 하나의 이벤트처럼 처리되므로 중간에 변경된 모든 state를 각각 렌더링하지 않습니다.
    /// 출처: ChatGPT
    ///
    /// 그럼에도 불구하고 코드 분기처리하여 안전하게 작성하기
    if (isInit) {
      inGameBoardStatus.changeStatus(pieceModel.x, pieceModel.y, pieceModel);
      state.add(InGamePiece(key: GlobalKey(), pieceModel: pieceModel));
    } else {
      if (pieceModel.team == Team.blue) {
        if (pieceModel.pieceType == PieceType.zol) {
          if (_numOfPiece[pieceModel.pieceType]! >= 5) {
            ref
                .read(inGameSystemNotificationProvider.notifier)
                .notifySystemError('기물의 수가 최대입니다');
            return;
          }
        } else {
          if (_numOfPiece[pieceModel.pieceType]! >= 2) {
            ref
                .read(inGameSystemNotificationProvider.notifier)
                .notifySystemError('기물의 수가 최대입니다');
            return;
          }
        }

        final gold = ref.read(inGameGoldProvider);

        if (gold < pieceModel.value) {
          ref
              .read(inGameSystemNotificationProvider.notifier)
              .notifySystemError('골드가 부족합니다');
          return;
        }

        /// 모든 조건이 맞을 때

        /// 골드 차감
        ref
            .read(inGameGoldProvider.notifier)
            .setInGameGold(gold - pieceModel.value);

        /// 기물 수 증가
        _numOfPiece[pieceModel.pieceType] =
            _numOfPiece[pieceModel.pieceType]! + 1;

        /// 골드 노티피케이션
        ref
            .read(getGoldNotificationWidgetProvider.notifier)
            .showGoldNotification(false, pieceModel.value);
      }

      /// 상태 변경
      inGameBoardStatus.changeStatus(pieceModel.x, pieceModel.y, pieceModel);
      final newState = state;
      newState.add(InGamePiece(key: GlobalKey(), pieceModel: pieceModel));
      state = newState;

      makePieceSpawnSound(pieceModel.pieceType);
    }
  }

  /// 기물 제거
  void removePiece(PieceActionableModel pieceActionable,
      [bool isExecute = false]) {
    final gold = ref.read(inGameGoldProvider);
    final targetPieceModel = inGameBoardStatus.getStatus(
        pieceActionable.targetX, pieceActionable.targetY);

    if (isExecute) {
      if (gold < 300) {
        ref
            .read(inGameSystemNotificationProvider.notifier)
            .notifySystemError('골드가 부족합니다');
        return;
      }

      /// 골드 차감
      ref.read(inGameGoldProvider.notifier).setInGameGold(gold - 300);

      /// 골드 노티피케이션
      ref
          .read(getGoldNotificationWidgetProvider.notifier)
          .showGoldNotification(false, 300);

      /// 처형 기물이 방금 움직인 기물
      if (targetPieceModel == lastTurnPiece) {
        lastTurnPiece = null;
      }

      /// 처형 기물이 방금 탭한 기물
      if (targetPieceModel == selectedPieceModel) {
        selectedPieceModel = null;
      }

      makeExecuteOrJanggoonSound();
    } else {
      /// 처형이 아닌 단순 기물 공격, 초가 한 기물을 취함
      if (targetPieceModel is PieceBaseModel) {
        if (targetPieceModel.team == Team.red) {
          /// 골드 증액
          ref
              .read(inGameGoldProvider.notifier)
              .setInGameGold(gold + pieceActionable.targetValue);

          /// 골드 노티피케이션
          ref
              .read(getGoldNotificationWidgetProvider.notifier)
              .showGoldNotification(true, targetPieceModel.value);

          makePieceKilledSound(Team.red);
        } else {
          makePieceKilledSound(Team.blue);
        }
      }
    }

    /// 제거되는 대상이 초나라 기물이면 기물 수 차감
    if (targetPieceModel is PieceBaseModel) {
      if (targetPieceModel.team == Team.blue) {
        _numOfPiece[targetPieceModel.pieceType] =
            _numOfPiece[targetPieceModel.pieceType]! - 1;
      }
    }

    inGameBoardStatus.changeStatus(
      pieceActionable.targetX,
      pieceActionable.targetY,
      PieceActionableModel(
        targetX: pieceActionable.targetX,
        targetY: pieceActionable.targetY,
        targetValue: 0,
      ),
    );
    final newState = state;
    newState.removeWhere(
      (piece) =>
          pieceActionable.targetX == piece.pieceModel.x &&
          pieceActionable.targetY == piece.pieceModel.y,
    );
    state = List.from(newState);
  }
}
