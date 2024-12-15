import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_cha_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_ma_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_po_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_sang_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_zol_model.dart';
import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_byung_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_cha_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_king_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_ma_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_po_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_sa_model.dart';
import 'package:samyeonchoga/model/in_game/red_piece/red_sang_model.dart';
import 'package:samyeonchoga/provider/in_game/in_game_board_status.dart';
import 'package:samyeonchoga/provider/lineup/lineup.dart';
import 'package:samyeonchoga/ui/in_game/widget/in_game_piece.dart';

part 'in_game_piece_set_provider.g.dart';

@Riverpod()
final class InGamePieceSet extends _$InGamePieceSet {
  @override
  List<InGamePiece> build() {
    return <InGamePiece>[];
  }

  void initPieceSet() {
    /// 초나라 포진 설정
    switch (lineup) {
      case Lineup.maSangMaSang:
        spawnPiece(RedMaModel(x: 1, y: 9), true);
        spawnPiece(RedSangModel(x: 2, y: 9), true);
        spawnPiece(RedMaModel(x: 6, y: 9), true);
        spawnPiece(RedSangModel(x: 7, y: 9), true);
        break;
      case Lineup.sangMaSangMa:
        spawnPiece(RedSangModel(x: 1, y: 9), true);
        spawnPiece(RedMaModel(x: 2, y: 9), true);
        spawnPiece(RedSangModel(x: 6, y: 9), true);
        spawnPiece(RedMaModel(x: 7, y: 9), true);
        break;
      case Lineup.maSangSangMa:
        spawnPiece(RedMaModel(x: 1, y: 9), true);
        spawnPiece(RedSangModel(x: 2, y: 9), true);
        spawnPiece(RedSangModel(x: 6, y: 9), true);
        spawnPiece(RedMaModel(x: 7, y: 9), true);
        break;
      default:
        spawnPiece(RedSangModel(x: 1, y: 9), true);
        spawnPiece(RedMaModel(x: 2, y: 9), true);
        spawnPiece(RedMaModel(x: 6, y: 9), true);
        spawnPiece(RedSangModel(x: 7, y: 9), true);
        break;
    }

    spawnPiece(RedKingModel(x: 4, y: 8), true);
    spawnPiece(RedSaModel(x: 3, y: 9), true);
    spawnPiece(RedSaModel(x: 5, y: 9), true);

    spawnPiece(RedChaModel(x: 0, y: 9), true);
    spawnPiece(RedChaModel(x: 8, y: 9), true);

    spawnPiece(RedPoModel(x: 1, y: 7), true);
    spawnPiece(RedPoModel(x: 7, y: 7), true);

    spawnPiece(RedByungModel(x: 0, y: 6), true);
    spawnPiece(RedByungModel(x: 2, y: 6), true);
    spawnPiece(RedByungModel(x: 4, y: 6), true);
    spawnPiece(RedByungModel(x: 6, y: 6), true);
    spawnPiece(RedByungModel(x: 8, y: 6), true);

    spawnPiece(BlueZolModel(x: 0, y: 3), true);
    spawnPiece(BlueZolModel(x: 2, y: 3), true);
    spawnPiece(BlueZolModel(x: 4, y: 3), true);
    spawnPiece(BlueZolModel(x: 6, y: 3), true);
    spawnPiece(BlueZolModel(x: 8, y: 3), true);

    spawnPiece(BluePoModel(x: 1, y: 2), true);
    spawnPiece(BluePoModel(x: 7, y: 2), true);

    spawnPiece(BlueChaModel(x: 0, y: 0), true);
    spawnPiece(BlueChaModel(x: 8, y: 0), true);

    final randomNumber = Random().nextInt(4);

    /// 한나라 포진 설정
    switch (randomNumber) {
      case 0:
        spawnPiece(BlueMaModel(x: 1, y: 0), true);
        spawnPiece(BlueSangModel(x: 2, y: 0), true);
        spawnPiece(BlueMaModel(x: 6, y: 0), true);
        spawnPiece(BlueSangModel(x: 7, y: 0), true);
        break;
      case 1:
        spawnPiece(BlueSangModel(x: 1, y: 0), true);
        spawnPiece(BlueMaModel(x: 2, y: 0), true);
        spawnPiece(BlueSangModel(x: 6, y: 0), true);
        spawnPiece(BlueMaModel(x: 7, y: 0), true);
        break;
      case 2:
        spawnPiece(BlueMaModel(x: 1, y: 0), true);
        spawnPiece(BlueSangModel(x: 2, y: 0), true);
        spawnPiece(BlueSangModel(x: 6, y: 0), true);
        spawnPiece(BlueMaModel(x: 7, y: 0), true);
        break;
      default:
        spawnPiece(BlueSangModel(x: 1, y: 0), true);
        spawnPiece(BlueMaModel(x: 2, y: 0), true);
        spawnPiece(BlueMaModel(x: 6, y: 0), true);
        spawnPiece(BlueSangModel(x: 7, y: 0), true);
        break;
    }

    state = List.from(state);
  }

  /// 기물 부활
  void spawnPiece(PieceBaseModel pieceModel, [bool isInit = false]) {
    changeStatus(pieceModel.x, pieceModel.y, pieceModel);

    /// ref.watch가 state가 변경될 때마다 위젯을 다시 빌드하게 하지만, state 자체가 변경된 횟수와 관계없이 최종적으로 변경된 상태에서만 빌드됩니다.
    /// Flutter와 Riverpod의 작동 방식에서 ref.watch는 state 객체가 변경되었을 때 반응하지만, 상태 변경이 하나의 이벤트처럼 처리되므로 중간에 변경된 모든 state를 각각 렌더링하지 않습니다.
    /// 출처: ChatGPT
    ///
    /// 그럼에도 불구하고 코드 분기처리하여 안전하게 작성하기
    if (isInit) {
      state.add(InGamePiece(key: GlobalKey(), pieceModel: pieceModel));
    } else {
      final newState = state;
      newState.add(InGamePiece(key: GlobalKey(), pieceModel: pieceModel));
      state = newState;
    }
  }

  /// 기물 제거
  void removePiece(int targetX, int targetY) {
    changeStatus(targetX, targetY, null);

    final newState = state;
    newState.removeWhere(
      (piece) => targetX == piece.pieceModel.x && targetY == piece.pieceModel.y,
    );
    state = List.from(newState);
  }
}
