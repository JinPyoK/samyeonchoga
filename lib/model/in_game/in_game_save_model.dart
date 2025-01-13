import 'package:isar/isar.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';

part 'in_game_save_model.g.dart';

@embedded
final class InGameSaveModel {
  /// 기물의 팀 소속
  @enumerated
  final Team team;

  /// 기물 타입
  @enumerated
  final PieceType pieceType;

  /// 기물의 현재 좌표
  final int x;
  final int y;

  const InGameSaveModel({
    this.team = Team.blue,
    this.pieceType = PieceType.king,
    this.x = 4,
    this.y = 8,
  });
}
