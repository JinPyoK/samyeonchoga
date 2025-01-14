import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'in_game_move_provider.g.dart';

@Riverpod()
final class InGameMove extends _$InGameMove {
  @override
  int build() {
    return 1;
  }

  void nextMove() {
    state = state + 1;
  }

  void setMove(int move) {
    state = move;
  }
}
