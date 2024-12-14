import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';

part 'in_game_spawn_piece_provider.g.dart';

@Riverpod()
final class InGameSpawnPieceProvider extends _$InGameSpawnPieceProvider {
  @override
  KindOfPiece build() {
    return KindOfPiece.cha;
  }

  void changeSpawnPiece(KindOfPiece piece) {
    state = piece;
  }
}
