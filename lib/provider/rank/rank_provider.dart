import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samyeonchoga/model/rank/rank_model.dart';
import 'package:samyeonchoga/model/rank/rank_state_model.dart';
import 'package:samyeonchoga/provider/rank/rank_state_provider.dart';
import 'package:samyeonchoga/repository/rank/rank_repository.dart';

part 'rank_provider.g.dart';

final _repo = RankRepository();

@Riverpod(keepAlive: true)
final class Rank extends _$Rank {
  @override
  List<RankModel> build() {
    return <RankModel>[];
  }

  Future<void> getRankList() async {
    try {
      ref
          .read(rankStateProvider.notifier)
          .changeRankState(rankState: RankStateEnum.loading);

      final rankList = await _repo.readRank();

      /// 랭크 데이터가 없을 경우
      if (rankList.isEmpty) {
        ref.read(rankStateProvider.notifier).changeRankState(
            rankState: RankStateEnum.error, errorMessage: '랭크 데이터가 존재하지 않습니다.');
        return;
      }

      state = rankList;

      ref
          .read(rankStateProvider.notifier)
          .changeRankState(rankState: RankStateEnum.fetch);
    } catch (_) {
      ref.read(rankStateProvider.notifier).changeRankState(
            rankState: RankStateEnum.error,
            errorMessage: '랭크 데이터를 불러오는 도중 에러가 발생했습니다',
          );
    }
  }

  Future<void> registerRank({required RankModel rankModel}) async {
    await _repo.writeRank(rankModel: rankModel);
  }
}
