import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samyeonchoga/model/rank/rank_model.dart';
import 'package:samyeonchoga/model/rank/rank_state_model.dart';
import 'package:samyeonchoga/provider/rank/rank_provider.dart';
import 'package:samyeonchoga/provider/rank/rank_state_provider.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';
import 'package:samyeonchoga/ui/common/widget/loading_skeleton.dart';
import 'package:samyeonchoga/ui/rank/widget/rank_refresh_button.dart';
import 'package:samyeonchoga/ui/rank/widget/rank_tile.dart';

class RankScreen extends ConsumerStatefulWidget {
  const RankScreen({super.key});

  @override
  ConsumerState<RankScreen> createState() => _RankScreenState();
}

class _RankScreenState extends ConsumerState<RankScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(rankProvider.notifier).getRankList();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final rankList = ref.watch(rankProvider);
    final rankState = ref.watch(rankStateProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20 * wu),
              child: Text(
                "랭크",
                style: TextStyle(
                  fontSize: 36 * hu,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const RankRefreshButton(),
          ],
        ),
        if (rankState.state == RankStateEnum.loading)
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: LoadingSkeleton(),
          ),
        if (rankState.state == RankStateEnum.error)
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: Text(rankState.errorMessage!),
            ),
          ),
        if (rankState.state == RankStateEnum.fetch)
          Expanded(
            child: ListView.builder(
              itemCount: rankList.length,
              itemBuilder: (_, index) {
                return RankTile(
                  rank: index + 1,
                  model: RankModel(
                    id: rankList[index].id,
                    round: rankList[index].round,
                    nickName: rankList[index].nickName,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
