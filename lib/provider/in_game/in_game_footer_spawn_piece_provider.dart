import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';

part 'in_game_footer_spawn_piece_provider.g.dart';

@Riverpod()
final class InGameFooterSpawnPiece extends _$InGameFooterSpawnPiece {
  @override
  PieceType build() {
    return PieceType.cha;
  }

  void changeSpawnPiece(PieceType piece) {
    state = piece;
  }
}
