import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samyeonchoga/provider/gold/gold_entity.dart';

part 'in_game_gold_provider.g.dart';

@Riverpod(keepAlive: true)
final class InGameGold extends _$InGameGold {
  @override
  int build() {
    return myGold.gold >= 3000 ? 3000 : myGold.gold;
  }

  void setInGameGold(int gold) {
    state = gold;
  }
}
