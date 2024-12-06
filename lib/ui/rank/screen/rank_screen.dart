import 'package:flutter/material.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';
import 'package:samyeonchoga/ui/rank/widget/rank_tile.dart';

class RankScreen extends StatelessWidget {
  const RankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Text(
            "랭크",
            style: TextStyle(
              fontSize: 36 * hu,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 100,
            itemBuilder: (_, index) {
              return RankTile(
                ranking: index + 1,
                round: 538,
                nickName: 'nickName',
              );
            },
          ),
        ),
      ],
    );
  }
}
