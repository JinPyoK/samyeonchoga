import 'package:flutter/material.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_cha_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_king_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_ma_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_po_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_sa_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_sang_model.dart';
import 'package:samyeonchoga/model/in_game/blue_piece/blue_zol_model.dart';
import 'package:samyeonchoga/model/in_game/piece_actionable_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/provider/in_game/in_game_board_status.dart';

import 'red_piece/red_byung_model.dart';
import 'red_piece/red_cha_model.dart';
import 'red_piece/red_ma_model.dart';
import 'red_piece/red_po_model.dart';
import 'red_piece/red_sang_model.dart';

abstract base class PieceOrJustActionable {}

abstract base class PieceBaseModel extends PieceOrJustActionable {
  /// 기물의 팀 소속
  final Team team;

  /// 기물 타입
  final PieceType pieceType;

  /// 기물의 가치 -> 봇 기물: 한나라의 미니맥스 알고리즘 가치 / 유저 기물: 한나라 기물을 취했을 때 얻는 골드
  final int value;

  /// 기물의 이미지 프로바이더 (precached)
  final ImageProvider imageProvider;

  /// 기물을 방금 착수했는지 -> UI 표시
  bool justTurn = false;

  /// 기물을 방금 탭했는지 -> UI 표시
  bool justTapped = false;

  /// 기물의 현재 좌표
  int x;
  int y;

  /// 이 기물이 취할 수 있는 액션
  List<PieceActionableModel> pieceActionable = [];

  PieceBaseModel({
    required this.team,
    required this.pieceType,
    required this.value,
    required this.imageProvider,
    required this.x,
    required this.y,
  });

  PieceBaseModel getNewPieceInstance() {
    late PieceBaseModel pieceModel;

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

    return pieceModel;
  }

  /// 기물의 움직임 애니메이션 setState
  void Function(void Function())? setStateThisPiece;

  /// 기물 길 찾기 함수
  void searchActionable(InGameBoardStatus statusBoard) {}
}

abstract base class BluePieceBaseModel extends PieceBaseModel {
  BluePieceBaseModel({
    required super.x,
    required super.y,
    required super.team,
    required super.pieceType,
    required super.value,
    required super.imageProvider,
  }) : super();
}

abstract base class RedPieceBaseModel extends PieceBaseModel {
  /// 현재 이 기물이 장군을 부르고 있는가? (한나라 기물만 해당)
  bool isTargetingKing = false;

  /// 장군인지 파악
  void doesThisPieceCallJanggoon() {
    isTargetingKing = false;

    for (PieceActionableModel actionable in pieceActionable) {
      if (actionable.targetValue == 1000) {
        isTargetingKing = true;
        break;
      }
    }
  }

  RedPieceBaseModel({
    required super.x,
    required super.y,
    required super.team,
    required super.pieceType,
    required super.value,
    required super.imageProvider,
  }) : super();
}
