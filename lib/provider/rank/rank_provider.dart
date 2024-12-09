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

      final data = await _repo.readRank();

      /// 랭크 데이터가 없을 경우
      if (data == null) {
        ref.read(rankStateProvider.notifier).changeRankState(
            rankState: RankStateEnum.error, errorMessage: '랭크 데이터가 존재하지 않습니다.');
        return;
      }

      List<RankModel> rankList = [];

      final rankObject = data as Map<String, dynamic>;
      final rankListObject = rankObject['rank'] as Map<String, dynamic>;

      for (String key in rankListObject.keys) {
        rankList.add(
          RankModel(
            id: key,
            round: rankListObject[key]['round'] as int,
            nickName: rankListObject[key]['nickName'] as String,
          ),
        );
      }

      /// 순위대로 오름차순 정렬
      rankList.sort((p, n) => p.round.compareTo(n.round));

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
    if (state.length < 100) {
      await _repo.removeLastAndWriteRank(targetId: null, model: rankModel);
    } else {
      final lastId = state.last.id;
      await _repo.removeLastAndWriteRank(targetId: lastId, model: rankModel);
    }
  }
}
