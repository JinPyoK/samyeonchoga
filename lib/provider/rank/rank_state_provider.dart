import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samyeonchoga/model/rank/rank_state_model.dart';

part 'rank_state_provider.g.dart';

@Riverpod(keepAlive: true)
final class RankState extends _$RankState {
  @override
  RankStateModel build() {
    return RankStateModel(state: RankStateEnum.loading);
  }

  void changeRankState({
    required RankStateEnum rankState,
    String? errorMessage,
  }) {
    state = RankStateModel(state: rankState, errorMessage: errorMessage);
  }
}
