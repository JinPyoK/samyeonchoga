import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'in_game_round_provider.g.dart';

@Riverpod()
final class InGameRound extends _$InGameRound {
  @override
  int build() {
    return 1;
  }

  void nextRound() {
    state = state + 1;
  }

  void setRound(int round) {
    state = round;
  }
}
