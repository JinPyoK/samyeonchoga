import 'package:flutter/material.dart';
import 'package:samyeonchoga/model/in_game/piece_actionable_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';

abstract base class PieceBaseModel {
  /// 기물의 팀 소속
  final Team team;

  /// 기물 타입
  final PieceType pieceType;

  /// 기물의 가치 -> 한: 초나라의 미니맥스 알고리즘 가치 / 초: 초나라 기물을 취했을 때 얻는 골드
  final int value;

  /// 기물의 이미지 프로바이더 (precached)
  final ImageProvider imageProvider;

  /// 기물의 현재 좌표
  int x;
  int y;

  /// 이 기물이 취할 수 있는 액션
  List<PieceActionableModel> actionable = [];

  /// 기물의 움직임 애니메이션 setState
  void Function(void Function())? setStateThisPiece;

  PieceBaseModel({
    required this.team,
    required this.pieceType,
    required this.value,
    required this.imageProvider,
    required this.x,
    required this.y,
  });

  /// 기물 길 찾기 함수
  void searchActionable() {}
}

abstract base class RedPieceBaseModel extends PieceBaseModel {
  RedPieceBaseModel({
    required super.x,
    required super.y,
    required super.team,
    required super.pieceType,
    required super.value,
    required super.imageProvider,
  }) : super();
}

abstract base class BluePieceBaseModel extends PieceBaseModel {
  /// 현재 이 기물이 장군을 부르고 있는가? (초나라 기물만 해당)
  bool isTargetingKing = false;

  BluePieceBaseModel({
    required super.x,
    required super.y,
    required super.team,
    required super.pieceType,
    required super.value,
    required super.imageProvider,
  }) : super();
}