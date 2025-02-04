import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samyeonchoga/ui/common/screen/home_navigation_screen.dart';

part 'in_game_gold_provider.g.dart';

@Riverpod(keepAlive: true)
final class InGameGold extends _$InGameGold {
  @override
  int build() {
    return myGolds >= 3000 ? 3000 : myGolds;
  }

  void setInGameGold(int gold) {
    state = gold;
  }
}
