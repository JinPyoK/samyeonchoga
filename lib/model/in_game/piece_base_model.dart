import 'package:flutter/material.dart';
import 'package:samyeonchoga/model/in_game/piece_actionable_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';

abstract base class PieceBaseModel {
  /// 기물의 팀 소속
  final Team team;

  /// 기물 타입
  final PieceType pieceType;

  /// 기물의 가치 ex) 차 130, 포 70, 마 50
  final int value;

  /// 기물의 이미지 프로바이더 (precached)
  final ImageProvider imageProvider;

  /// 기물의 현재 좌표
  int x;
  int y;

  /// 현재 이 기물이 장군을 부르고 있는가?
  bool isTargetingKing = false;

  /// 이 기물이 취할 수 있는 액션
  List<PieceActionableModel> actionable = [];

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
