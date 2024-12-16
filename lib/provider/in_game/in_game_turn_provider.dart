import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samyeonchoga/provider/in_game/in_game_round_provider.dart';

part 'in_game_turn_provider.g.dart';

@Riverpod()
final class InGameTurn extends _$InGameTurn {
  @override
  bool build() {
    return false;
  }

  void changeTurn() {
    state = !state;
    
    /// 초나라의 턴이라면 라운드를 증가시키고 초나라 착수
    if (!state) {
      ref.read(inGameRoundProvider.notifier).nextRound();
      _blueAction();
    }
  }

  void _blueAction() {}
}
